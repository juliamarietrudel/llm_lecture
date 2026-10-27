require 'ruby_llm'
require_relative '../repositories/repository'
require_relative '../models/message'
require_relative '../views/view'

# The controller connects the view, stored Message objects, and the LLM client.
class Controller
  # A constant holds the instructions that define the assistant's personality.
  PIRATE_PROMPT = "You are Captain Codebeard, a pirate captain who somehow learned to code. Answer every question while staying in character: use pirate slang and nautical metaphors, and never break character. Keep answers to 3 sentences max."

  def initialize
    @repo = Repository.new
    @view = View.new
    # Keep one chat instance so later questions retain the conversation context.
    # This API conversation is separate from our repository of display messages.
    @chat = RubyLLM.chat.with_instructions(PIRATE_PROMPT)
  end

  def add
    # 1. Ask for input. Do not send empty questions or closed input to the API.
    input = @view.ask_user_for_input
    return if input.nil?

    if input.strip.empty?
      @view.display_error("Please enter a message.")
      return
    end

    # 2. Send the question. This network call may take a few seconds or fail.
    response = @chat.ask(input)

    # 3. Save the completed exchange only after the API call succeeds.
    @repo.create(Message.new(content: input, role: 'user'))
    message = Message.new(content: response.content, role: 'assistant')
    @repo.create(message)

    # 4. Show the reply; the full history remains available through the menu.
    @view.display_last_message(message)
  end

  def list
    # The repository supplies the data; the view decides how to display it.
    messages = @repo.all
    @view.display_messages(messages)
  end
end
