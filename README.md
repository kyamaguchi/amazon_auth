# AmazonAuth

[![Gem Version](https://badge.fury.io/rb/amazon_auth.svg)](https://badge.fury.io/rb/amazon_auth)
[![Build Status](https://travis-ci.org/kyamaguchi/amazon_auth.svg?branch=master)](https://travis-ci.org/kyamaguchi/amazon_auth)

Sign In Amazon using Capybara and Selenium

![amazon_auth_login](https://cloud.githubusercontent.com/assets/275284/25064724/7f5faae4-223b-11e7-9fc6-4a82d1d727ab.gif)

Recorded with [Recordit](http://recordit.co/)

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

- chromedriver

Before running, you need to **download chromedriver**.  
And you may need to **update chromedriver regularly**.  
Please download latest chromedriver_xxx.zip from http://chromedriver.storage.googleapis.com/index.html and place it somewhere on your PATH.

```
mv ~/Downloads/chromedriver /usr/local/bin/
```

## Usage

### Set Amazon credentials on your local machine

[Quick] You can set login and password in console.

[Recommended] Or you can convert them to protect them against shoulder surfing.
Run `amazon_auth` and paste the output to _.env_.
(`AMAZON_USERNAME_CODE` , `AMAZON_PASSWORD_CODE` and `AMAZON_CODE_SALT`)

![amazon_auth_setup](https://cloud.githubusercontent.com/assets/275284/25064607/9b9b80be-2238-11e7-95fc-c1547a83f178.gif)

### envchain for security

You can store environment variables in macOS Keychain instead of dotenv.
Check out [envchain](https://github.com/sorah/envchain)

```
brew install envchain

envchain --set amazon AMAZON_DOMAIN AMAZON_USERNAME_CODE AMAZON_PASSWORD_CODE AMAZON_CODE_SALT

# Run console with envchain
envchain amazon bin/console
envchain amazon bundle exec irb
envchain amazon rails console
```

### Run

In console, you can move around pages using Capybara DSL

```ruby
# Without credentials in .env
client = AmazonAuth::Client.new(login: 'your_amazon_email', password: 'your_amazon_password')

# With credentials in .env
client = AmazonAuth::Client.new

# Sign in
client.sign_in

# Continue to the page for Kindle
link = client.links_for('#navFooter a').find{|link| link =~ %r{/gp/digital/fiona/manage/} }
client.session.visit link
```

### Use amazon site in different domain

Set `AMAZON_DOMAIN` in _.env_.

e.g. `AMAZON_DOMAIN=amazon.co.jp` for Japanese site

### Keep cookies

Using [capybara-sessionkeeper gem](https://github.com/kyamaguchi/capybara-sessionkeeper)

```
client = AmazonAuth::Client.new(keep_cookie: true, debug: true)
```

You can change Capyabra.save_path when it isn't set

```
client = AmazonAuth::Client.new(keep_cookie: true, save_path: 'tmp/cookies', debug: true)
```

### Logging

Normal logging

```ruby
client = AmazonAuth::Client.new(verbose: true)
```

More logging (This includes `session.current_url`)

```ruby
client = AmazonAuth::Client.new(debug: true)
```

### Use Firefox

This gem may not work with newer versions of Firefox.  
Check README of [capybara](https://github.com/teamcapybara/capybara).  

Firefox (<= 47.0.2) may work better.  

[Download Firefox](https://ftp.mozilla.org/pub/firefox/releases/)  
Don't forget to disable automatic updates of Firefox.  

You may also need geckodriver.  
This may need to be older depending on the version of selenium-webdriver.  

[Download geckodriver](https://github.com/mozilla/geckodriver/releases)  

If the browser doesn't work, try selenium-webdriver version '~> 2.0' or different version of geckodriver/Firefox.

In console,

```
client = AmazonAuth::Client.new(driver: :firefox)
```

## TODO

- [Idea] Hook `submit_signin_form` after every `visit` and `click` action

## Development

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

