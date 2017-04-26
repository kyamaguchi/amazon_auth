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
      @driver = options.fetch(:driver, :selenium)
    end

    def links_for(selector, options = {})
      wait_for_selector(selector, options)
      doc.css(selector).map{|e| e['href'] }
    end

    def wait_for_selector(selector, options = {})
      options.fetch(:wait_time, 3).times do
        if session.first(selector)
          break
        else
          sleep(1)
        end
      end
    end

    def sign_in
      session.visit initial_url
      link = links_for('#nav-signin-tooltip a').find{|link| link =~ %r{\A/gp/navigation/redirector.html} }
      session.visit(link) if link
      submit_signin_form
    end

    def submit_signin_form
      return true unless session.has_selector?('#signInSubmit')
      session.fill_in 'ap_email', with: @login
      session.fill_in 'ap_password', with: @password
      session.click_on('signInSubmit')

      raise('Failed on signin') if alert_displayed?
      while image_recognition_displayed? do
        retry_signin_form_with_image_recognition
      end
      true
    end

    def retry_signin_form_with_image_recognition
      session.fill_in 'ap_password', with: @password
      if image_recognition_displayed?
        input = ask "Got the prompt. Read characters from the image: "
        session.fill_in 'auth-captcha-guess', with: input
      end
      session.click_on('signInSubmit')
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

    def doc
      Nokogiri.HTML(session.html)
    end

    # Hide instance variables of credentials on console
    def inspect
      to_s
    end
  end
end
