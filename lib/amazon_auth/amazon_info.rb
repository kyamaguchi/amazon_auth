class AmazonInfo
  def self.domain
    ENV['AMAZON_DOMAIN'].presence || 'amazon.com'
  end
end
