# Entry point: run this file with `ruby app.rb` from the project directory.
# Load configuration first so the API key is available when we create the chat.
require_relative 'config'
require_relative 'app/controllers/controller'
require_relative 'router'

# The controller coordinates the conversation; the router handles menu choices.
controller = Controller.new
router = Router.new(controller)

# Start the menu loop. It ends when the user selects Exit or closes input.
router.run
