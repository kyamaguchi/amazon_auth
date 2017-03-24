# AmazonAuth

Sign In Amazon using Capybara and Selenium

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amazon_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amazon_auth

## Requirements

Firefox (<= 47.0.2)

This may not work with newer versions of Firefox.

## Usage

### Set Amazon credentials on your local machine

[Quick] You can set login and password in console.

[Recommended] Or you can convert them to protect them against shoulder surfing.
Run `amazon_auth` and paste the output to _.env_.
(`AMAZON_USERNAME_CODE` , `AMAZON_PASSWORD_CODE` and `AMAZON_CODE_SALT`)

### Run

In console, you can move around pages using Capybara DSL

```ruby
# Without credentials in .env
client = AmazonAuth::Client.new(login: 'your_amazon_email', password: 'your_amazon_password')

# With credentials in .env
client = AmazonAuth::Client.new

# Sign in
page = client.sign_in

# Continue to the page for Kindle
page.first('a', text: 'コンテンツと端末の管理').click

# Close browser
page.driver.quit
```

## Development

Some features come from https://github.com/kyamaguchi/kindle

Use _.env.development_ instead of _.env_ in development.

```
git clone https://github.com/kyamaguchi/amazon_auth.git
cd amazon_auth
bundle

./exe/amazon_auth
vi .env.development

rspec

./bin/console
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kyamaguchi/amazon_auth.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

