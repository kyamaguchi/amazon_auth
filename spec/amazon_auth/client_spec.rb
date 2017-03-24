require 'spec_helper'

describe AmazonAuth::Client do
  let(:valid_vars) do
    {
      'AMAZON_USERNAME_CODE' => 'aWxvdmVhbWF6b250ZXN0QGV4YW1wbGUuY29t',
      'AMAZON_PASSWORD_CODE' => 'aWxvdmVhbWF6b250ZXN0cGFzc3dvcmQ=',
      'AMAZON_CODE_SALT' => 'iloveamazon',
    }
  end

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
end

