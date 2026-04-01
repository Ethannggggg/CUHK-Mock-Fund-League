ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Load .env file for local development only (not in test/CI environments)
unless ENV["RAILS_ENV"] == "test" || ENV["CI"]
  require "dotenv"
  Dotenv.load(File.expand_path("../../.env", __dir__))
end
