module Niftycloud
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }
    
    include Hoge

    def url_encode(s)
      ERB::Util.url_encode(s)
    end
  end
end
