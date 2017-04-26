require 'spec_helper'

describe AmazonAuth::Client do

  describe '.new' do
    it "fails to initialize when login isn't given" do
      expect{
        AmazonAuth::Client.new(password: 'secret')
      }.to raise_error(/AMAZON_USERNAME_CODE/)
    end

    it "fails to initialize when password isn't given" do
      expect{
        AmazonAuth::Client.new(login: 'foo')
      }.to raise_error(/AMAZON_PASSWORD_CODE/)
    end

    it "succeeds in initializing when login and password are given" do
      expect{
        AmazonAuth::Client.new(login: 'foo', password: 'secret')
      }.to_not raise_error
    end

    it "succeeds in initializing when login and password codes are given with envvar" do
      with_env_vars valid_vars do
        expect{
          AmazonAuth::Client.new
        }.to_not raise_error
      end
    end

    it "fails to initialize when salt isn't set" do
      with_env_vars valid_vars.merge('AMAZON_CODE_SALT' => '') do
        expect{
          AmazonAuth::Client.new
        }.to raise_error(/salt/)
      end
    end
  end

  describe '#initial_url' do
    it 'has us domain by default' do
      with_env_vars valid_vars do
        client = AmazonAuth::Client.new
        expect(client.initial_url).to match(/www\.amazon\.com/)
      end
    end

    it 'switches domain with envvar' do
      with_env_vars valid_vars.merge('AMAZON_DOMAIN' => 'amazon.co.jp') do
        client = AmazonAuth::Client.new
        expect(client.initial_url).to match(/www\.amazon\.co\.jp/)
      end
    end

    it 'changes url with argument' do
      with_env_vars valid_vars do
        client = AmazonAuth::Client.new(url: 'https://www.amazon.co.uk')
        expect(client.initial_url).to match(/www\.amazon\.co\.uk/)
      end
    end
  end
end

