$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'amazon_auth'

Dir[File.join(File.dirname(__FILE__), "..", "spec", "support", "**/*.rb")].each {|f| require f}
