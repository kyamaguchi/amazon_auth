require 'spec_helper'

describe AmazonAuth::Client do

  describe '.new' do
    it "fails to initialize when login isn't given" do
      with_env_vars 'AMAZON_USERNAME_CODE' => '', 'AMAZON_USERNAME' => '' do
        expect{
          AmazonAuth::Client.new(password: 'secret')
        }.to raise_error(/AMAZON_USERNAME/)
      end
    end

    it "fails to initialize when password isn't given" do
      with_env_vars 'AMAZON_PASSWORD_CODE' => '', 'AMAZON_PASSWORD' => '' do
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

    it "succeeds in initializing when login and password are given with envvar" do
      with_env_vars 'AMAZON_USERNAME' => 'test@example.com', 'AMAZON_PASSWORD' => 'testpassword', 'AMAZON_USERNAME_CODE' => '', 'AMAZON_PASSWORD_CODE' => '' do
        expect{
          AmazonAuth::Client.new
        }.to_not raise_error
      end
    end

    it "succeeds in initializing when login and password codes are given with envvar" do
      with_env_vars 'AMAZON_USERNAME_CODE' => 'aWxvdmVhbWF6b250ZXN0QGV4YW1wbGUuY29t', 'AMAZON_PASSWORD_CODE' => 'aWxvdmVhbWF6b250ZXN0cGFzc3dvcmQ=', 'AMAZON_USERNAME' => '', 'AMAZON_PASSWORD' => '' do
        expect{
          AmazonAuth::Client.new
        }.to_not raise_error
      end
    end
  end
end

