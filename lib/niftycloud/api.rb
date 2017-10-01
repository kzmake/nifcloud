module Niftycloud
  class API < Request
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      (Configuration::VALID_OPTIONS_KEYS).each do |key|
        send("#{key}=", options[key]) if options[key]
      end
    end

  end
end