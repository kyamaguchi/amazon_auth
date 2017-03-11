require 'spec_helper'

describe AmazonAuth::Client do

  describe '.new' do
    it "fails to initialize when login isn't given" do
      with_env_vars 'AMAZON_USERNAME_CODE' => '' do
        expect{
          AmazonAuth::Client.new(password: 'secret')
        }.to raise_error(/AMAZON_USERNAME_CODE/)
      end
    end

    it "fails to initialize when password isn't given" do
      with_env_vars 'AMAZON_PASSWORD_CODE' => '' do
        expect{
          AmazonAuth::Client.new(login: 'foo')
        }.to raise_error(/AMAZON_PASSWORD_CODE/)
      end
    end

    it "succeeds in initializing when login and password are given" do
      expect{
        AmazonAuth::Client.new(login: 'foo', password: 'secret')
      }.to_not raise_error
    end

    it "succeeds in initializing when login and password codes are given with envvar" do
      with_env_vars 'AMAZON_USERNAME_CODE' => 'aWxvdmVhbWF6b250ZXN0QGV4YW1wbGUuY29t', 'AMAZON_PASSWORD_CODE' => 'aWxvdmVhbWF6b250ZXN0cGFzc3dvcmQ=' do
        expect{
          AmazonAuth::Client.new
        }.to_not raise_error
      end
    end

    it "fails to initialize when salt isn't set" do
      with_env_vars 'AMAZON_CODE_SALT' => '' do
        expect{
          AmazonAuth::Client.new
        }.to raise_error(/salt/)
      end
    end
  end
end

