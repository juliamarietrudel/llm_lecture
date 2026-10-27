# A model represents application data: one message and the role of its author.
# "user" is the student; "assistant" is the language model's reply.
class Message
  # Readers let other objects inspect these values without replacing them.
  attr_reader :content, :role

  # Example: Message.new(content: "Hello!", role: "user")
  # attr is a hash; symbols such as :content identify its keys.
  def initialize(attr = {})
    @content = attr[:content]
    @role = attr[:role]
  end
end
