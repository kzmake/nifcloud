module Niftycloud
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each {|f| require f}

    include Instances
    include Issues

    def url_encode(s)
      ERB::Util.url_encode(s)
    end

    def inspect
      inspected = super

      if @secret_key
        inspected = inspected.sub! @secret_key, only_show_last_four_chars(@secret_key)
      end

      inspected
    end

    private

    def only_show_last_four_chars(key)
      "#{'*'*(key.size - 4)}#{key[-4..-1]}"
    end
  end
end
