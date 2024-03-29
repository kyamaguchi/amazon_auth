$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'amazon_auth'
Dotenv.load('.env.test')

Dir[File.join(File.dirname(__FILE__), "..", "spec", "support", "**/*.rb")].sort.each {|f| require f}

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
end
