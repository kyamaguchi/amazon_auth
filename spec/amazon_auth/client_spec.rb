require 'spec_helper'

describe AmazonAuth::Client do

  describe '.new' do
    it "fails to initialize when login isn't given" do
      with_env_vars 'AMAZON_USERNAME' => '' do
        expect{
          AmazonAuth::Client.new(password: 'secret')
        }.to raise_error(/AMAZON_USERNAME/)
      end
    end

    it "fails to initialize when password isn't given" do
      with_env_vars 'AMAZON_PASSWORD' => '' do
        expect{
          AmazonAuth::Client.new(login: 'foo')
        }.to raise_error(/AMAZON_PASSWORD/)
      end
    end

    it "succeeds in initializing when login and password are given" do
      expect{
        AmazonAuth::Client.new(login: 'foo', password: 'secret')
      }.to_not raise_error
    end
  end
end

