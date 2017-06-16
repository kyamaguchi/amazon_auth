module AmazonAuth
  class Client
    include AmazonAuth::CommonExtension
    include AmazonAuth::SessionExtension

    attr_accessor :initial_url

    def initialize(options = {})
      @options = options
      @initial_url = options.fetch(:url) { "https://www.#{AmazonInfo.domain}/" }
      @login = options.fetch(:login) do
        if (amazon_username_code = ENV['AMAZON_USERNAME_CODE']).present?
          Converter.decode(amazon_username_code)
        else
          raise('AMAZON_USERNAME_CODE is required.')
        end
      end
      @password = options.fetch(:password) do
        if (amazon_password_code = ENV['AMAZON_PASSWORD_CODE']).present?
          Converter.decode(amazon_password_code)
        else
          raise('AMAZON_PASSWORD_CODE is required.')
        end
      end
      @driver = options.fetch(:driver, :selenium)

      Capybara.app_host = @initial_url
    rescue => e
      puts "Please setup credentials of amazon_auth gem with folloing its instruction."
      raise e
    end

    def sign_in
      session.visit initial_url
      debug "Visiting #{initial_url}"
      link = links_for('#nav-signin-tooltip a').find{|link| link =~ %r{\A/gp/navigation/redirector.html} }
      debug "link: [#{link}]"
      session.visit(link) if link
      submit_signin_form
    end

    def submit_signin_form
      debug "Begin submit_signin_form"
      return true unless session.has_selector?('#signInSubmit')
      session.fill_in 'ap_email', with: @login
      session.fill_in 'ap_password', with: @password
      session.click_on('signInSubmit')
      log "Clicked signInSubmit"

      raise('Failed on signin') if alert_displayed?
      while image_recognition_displayed? do
        retry_signin_form_with_image_recognition
      end
      debug "End submit_signin_form"
      true
    end

    def retry_signin_form_with_image_recognition
      return true unless session.has_selector?('#signInSubmit')
      session.fill_in 'ap_password', with: @password
      if image_recognition_displayed?
        input = ask "Got the prompt. Read characters from the image [blank to cancel]: "
        if input.blank?
          debug "Going back to #{initial_url}"
          session.visit initial_url
          return true
        end
        session.fill_in 'auth-captcha-guess', with: input
      end
      sleep 1
      session.click_on('signInSubmit')
      sleep 2
    end

    def alert_displayed?
      session.has_selector?('.a-alert-error')
    end

    def image_recognition_displayed?
      session.has_selector?('#auth-captcha-image-container')
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
