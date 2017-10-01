module Niftycloud
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }
    
    include Hoge
    include Issues

    def url_encode(s)
      ERB::Util.url_encode(s)
    end

    def inspect
      inspected = super

      if @private_token
        inspected = inspected.sub! @private_token, only_show_last_four_chars(@private_token)
      end

      inspected
    end

    private

    def only_show_last_four_chars(token)
      "#{'*'*(token.size - 4)}#{token[-4..-1]}"
    end
  end
end
