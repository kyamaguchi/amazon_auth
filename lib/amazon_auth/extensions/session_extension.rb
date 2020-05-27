module AmazonAuth
  module SessionExtension
    def doc
      Nokogiri.HTML(session.html)
    end

    def links_for(selector, options = {})
      wait_for_selector(selector, options)
      doc.css(selector).map{|e| e['href'] }
    end

    def wait_for_selector(selector, options = {})
      options.fetch(:wait_time, 3).times do
        if session.first(selector, minimum: 0)
          break
        else
          sleep(1)
        end
      end
    end

    # Helpers for sign in
    def initial_url
      options.fetch(:url) { "https://www.#{AmazonInfo.domain}/" }
    end

    def sign_in(url = nil)
      url ||= initial_url
      session.visit url
      debug "Visiting #{url}"
      restore_cookies if keep_cookie?
      if (link = links_for('a').find{|l| l =~ %r{\A/gp/navigation/redirector.html} })
        debug "link: [#{link}]"
        session.visit(link)
      end
      submit_signin_form
    end

    def restore_cookies
      log "Restoring cookies"
      wait_for_selector('body')
      session.restore_cookies
      session.visit session.current_url
      session.save_cookies
    end

    def keep_cookie?
      options[:keep_cookie]
    end

    def submit_signin_form
      # Click account switcher if it is displayed
      dom_account_switcher = '.cvf-account-switcher-profile-details, .cvf-account-switcher-claim'
      session.first(dom_account_switcher).click if session.has_selector?(dom_account_switcher)

      debug "Begin submit_signin_form"
      unless session.has_selector?('#signInSubmit')
        if session.has_selector?('input#continue') && session.has_selector?('input#ap_email')
          log "Found a form which asks only email"
          session.fill_in 'ap_email', with: login
          session.first('input#continue').click
        else
          log "signInSubmit button not found in this page"
          return false
        end
      end
      session.fill_in 'ap_email', with: login if session.first('#ap_email', minimum: 0) && session.first('#ap_email').value.blank?
      session.fill_in 'ap_password', with: password
      session.first('#signInSubmit').click
      log "Clicked signInSubmit"

      raise('Failed on signin') if alert_displayed?
      while image_recognition_displayed? do
        retry_signin_form_with_image_recognition
      end
      debug "End submit_signin_form"
      session.save_cookies if keep_cookie?
      true
    rescue => e
      raise("#{e.message} #{e.backtrace.first}\n\n#{session.body}")
    end

    def retry_signin_form_with_image_recognition
      return true unless session.has_selector?('#signInSubmit')
      session.fill_in 'ap_password', with: password
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

    private

    def login
      options.fetch(:login, Converter.decode(ENV['AMAZON_USERNAME_CODE']))
    end

    def password
      options.fetch(:password, Converter.decode(ENV['AMAZON_PASSWORD_CODE']))
    end
  end
end
