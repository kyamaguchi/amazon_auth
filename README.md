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

```
cp .env.sample .env
vi .env
```

### Set Amazon credentials on your local machine

[Quick] You can set `AMAZON_USERNAME` and `AMAZON_PASSWORD` in _.env_.

[Recommended] Or you can convert them to protect them against shoulder surfing.
Run `./exe/convert_amazon_credentials` and paste the output to _env_.
(`AMAZON_USERNAME_CODE` and `AMAZON_PASSWORD_CODE`)

You can change the salt with `AMAZON_CODE_SALT` if you like.

### Run

```
bin/console
```

You can move around pages using Capybara DSL

```ruby
client = AmazonAuth::Client.new
page = client.sign_in

# Continue to the page for Kindle
page.first('a', text: 'コンテンツと端末の管理').click

# Close browser
page.driver.quit
```

## Development

Some features come from https://github.com/kyamaguchi/kindle

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kyamaguchi/amazon_auth.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

