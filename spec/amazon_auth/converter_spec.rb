require 'spec_helper'

describe AmazonAuth::Converter do
  describe '#encode' do
    it "succeeds in encoding string" do
      expect(AmazonAuth::Converter.new('test').encode('hoge')).to eq('dGVzdGhvZ2U=')
    end
  end

  describe '.decode' do
    it "succeeds in decoding string" do
      expect(AmazonAuth::Converter.decode('dGVzdGhvZ2U=')).to eq('hoge')
    end
  end
end
