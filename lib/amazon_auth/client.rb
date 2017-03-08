module AmazonAuth
  class Client
    DEFAULT_ENTRY_URL = 'https://www.amazon.co.jp/ap/signin?_encoding=UTF8&openid.assoc_handle=jpflex&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.co.jp%2Fgp%2Fcss%2Fhomepage.html%3Fref_%3Dnav_signin'

    def initialize(options = {})
      @url = options.fetch(:url) { DEFAULT_ENTRY_URL }
      @login = options.fetch(:login) { ENV['AMAZON_USERNAME'].presence || raise('AMAZON_USERNAME is required.') }
      @password = options.fetch(:password) { ENV['AMAZON_PASSWORD'].presence || raise('AMAZON_PASSWORD is required.') }
    end
  end
end
