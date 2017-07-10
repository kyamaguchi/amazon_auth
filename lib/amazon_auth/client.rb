module AmazonAuth
  class Client
    include AmazonAuth::CommonExtension
    include AmazonAuth::SessionExtension

    attr_accessor :options

    def initialize(options = {})
      @options = options
      @driver = options.fetch(:driver, :selenium)
      # Check credentials
      raise('AMAZON_USERNAME_CODE is required.') unless (options[:login] || ENV['AMAZON_USERNAME_CODE']).present?
      raise('AMAZON_PASSWORD_CODE is required.') unless (options[:password] || ENV['AMAZON_PASSWORD_CODE']).present?
      Converter.salt if options[:login].blank? || options[:password].blank?

      Capybara.save_path = options.fetch(:save_path, 'tmp') if Capybara.save_path.nil?
      Capybara.app_host = initial_url if Capybara.app_host.nil?
    rescue => e
      puts "Please setup credentials of amazon_auth gem with folloing its instruction."
      raise e
    end

    def session
      @session ||= Capybara::Session.new(@driver)
    end

    # Hide instance variables of credentials on console
    def inspect
      to_s
    end
  end
end
