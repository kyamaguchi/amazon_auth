module AmazonAuth
  module CommonExtension
    def log(message)
      return unless (@options[:debug] || @options[:verbose])
      puts "[#{Time.current.strftime('%Y-%m-%d %H:%M:%S')}] #{message}" +
        (@options[:debug] && @session ? " -- #{session.current_url}" : '')
    end

    def debug(message)
      return unless @options[:debug]
      log(message)
    end
  end
end
