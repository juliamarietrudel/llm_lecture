# The view handles terminal input and output, without calling the language model.
class View
  def ask_user_for_input
    puts "\n"
    puts "-----------------------------"
    puts "What do you want to ask?"
    # Safe navigation (&.) avoids calling chomp on nil when input is closed.
    $stdin.gets&.chomp
  end

  def display_last_message(message)
    # The ternary operator chooses a display label based on the message's role.
    role = message.role == "user" ? "You" : "🏴‍☠️"
    puts "#{role} : #{message.content}"
    puts "-----------------------------"
    puts "\n"
  end

  def display_messages(messages)
    if messages.empty?
      puts "No messages yet. Choose 1 to start a conversation."
      return
    end

    # Reuse the same formatting for a single reply and the full history.
    messages.each do |message|
      display_last_message(message)
    end
  end

  def display_error(message)
    puts "Error: #{message}"
  end
end
