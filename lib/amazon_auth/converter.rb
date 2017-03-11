module AmazonAuth
  class Converter

    def self.encode(str)
      raise "Empty string" if str.to_s.size == 0
      Base64.strict_encode64("#{salt}#{str}")
    end

    def self.decode(code)
      raise "Empty string" if code.to_s.size == 0
      Base64.strict_decode64(code).gsub(/\A#{salt}/, '')
    end

    def self.salt
      ENV['AMAZON_CODE_SALT'] || "iloveamazon"
    end
  end
end
