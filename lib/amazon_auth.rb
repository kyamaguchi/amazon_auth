require 'dotenv'
Dotenv.load
require "active_support/all"
require "capybara"
require "highline/import"
require 'byebug'
require_relative "amazon_auth/version"
require_relative "amazon_auth/amazon_info"
require_relative "amazon_auth/converter"
require_relative "amazon_auth/client"

module AmazonAuth
end
