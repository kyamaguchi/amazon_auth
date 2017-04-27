module AmazonAuth
  module SessionExtension

    def doc
      Nokogiri.HTML(session.html)
    end

    def links_for(selector, options = {})
      wait_for_selector(selector, options)
      doc.css(selector).map{|e| e['href'] }
    end

    def wait_for_selector(selector, options = {})
      options.fetch(:wait_time, 3).times do
        if session.first(selector)
          break
        else
          sleep(1)
        end
      end
    end
  end
end
