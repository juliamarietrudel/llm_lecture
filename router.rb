# The router translates terminal menu choices into controller actions.
class Router
  def initialize(controller)
    # Receive the controller instead of creating it here (dependency injection).
    @controller = controller
    @running = true
  end

  def run
    while @running
      display_menu
      # gets returns nil at end of input (for example, Ctrl-D in a terminal).
      input = $stdin.gets
      break if input.nil?

      # Keep the choice as text: to_i would also turn "1hello" into 1.
      dispatch(input.strip)
    end
  end

  private

  # Private methods are implementation details used by the public run method.
  def display_menu
    puts "1. Send a message"
    puts "2. Display all messages"
    puts "3. Exit"
  end

  def dispatch(choice)
    case choice
    when "1" then @controller.add
    when "2" then @controller.list
    when "3" then stop
    else
      puts "Please choose 1, 2, or 3."
    end
  end

  def stop
    @running = false
  end
end
