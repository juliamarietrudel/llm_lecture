# Load local environment variables before configuring the API client.
# Store OPENAI_API_KEY in .env; never commit that file or the key to Git.
require "dotenv/load"
require "ruby_llm"

# ENV reads configuration from the environment, keeping secrets out of Ruby code.
RubyLLM.configure do |config|
  config.openai_api_key = ENV["OPENAI_API_KEY"]
end
