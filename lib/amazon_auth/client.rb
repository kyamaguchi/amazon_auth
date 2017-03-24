module AmazonAuth
  class Client
    attr_accessor :initial_url

    def initialize(options = {})
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
    end

    def sign_in
      session.visit initial_url
      session.first('#a-autoid-0-announce').click

      fill_in_with_stroke('ap_email', @login)
      fill_in_with_stroke('ap_password', @password)
      session.click_on('signInSubmit')

      while alert_displayed? do
        retry_sign_in
      end

      session.first('.nav-line-2').click
      session
    end

    def retry_sign_in
      fill_in_with_stroke('ap_password', @password)
      if image_recognition_displayed?
        input = ask "Got the prompt. Read characters from the image: "
        fill_in_with_stroke('auth-captcha-guess', input)
      end
      session.click_on('signInSubmit')
    end

    def fill_in_with_stroke(dom_id, value)
      sleep_s
      element = session.first("##{dom_id}")
      value.split(//u).each do |char|
        element.send_keys(char)
        sleep rand
      end
    end

    def alert_displayed?
      session.has_selector?('.a-alert-container')
    end

    def image_recognition_displayed?
      session.has_selector?('#auth-captcha-image-container')
    end

    def session
      @session ||= Capybara::Session.new(:selenium)
    end

    def driver
      session.driver
    end

    def sleep_s(sec = 2)
      sleep sec
    end

    # Hide instance variables of credentials on console
    def inspect
      to_s
    end
  end
end
