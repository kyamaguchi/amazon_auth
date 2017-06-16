require 'dotenv'
Dotenv.load
require "active_support/all"
require "capybara"
require "highline/import"
begin
  require 'byebug'
rescue LoadError
end
require_relative "amazon_auth/version"
require_relative "amazon_auth/extensions/common_extension"
require_relative "amazon_auth/extensions/session_extension"
require_relative "amazon_auth/amazon_info"
require_relative "amazon_auth/capybara"
require_relative "amazon_auth/converter"
require_relative "amazon_auth/client"

module AmazonAuth
end
