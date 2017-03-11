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
bin/console
```

You can move around pages using Capybara DSL

```ruby
client = AmazonAuth::Client.new(login: 'your_email@example.com', password: 'your_amazon_password')
page = client.sign_in

# Continue to the page for Kindle
page.first('a', text: 'コンテンツと端末の管理').click

# Close browser
page.driver.quit
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kyamaguchi/amazon_auth.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

