# The repository stores messages in insertion order, in memory only.
# Exiting the program loses this history; no database or file is used.
class Repository
  def initialize
    @messages = []
  end

  def all
    # Return an array copy so callers cannot add/remove stored entries directly.
    @messages.dup
  end

  def create(message)
    # << appends one Message object to the end of the array.
    @messages << message
  end
end
