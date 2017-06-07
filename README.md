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

Before running, you need to download chromedriver.  
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

