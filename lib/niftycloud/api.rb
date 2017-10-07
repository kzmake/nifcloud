module Niftycloud
  class API < Request
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Niftycloud.options.merge(options)
      (Configuration::VALID_OPTIONS_KEYS + [:secret_key]).each do |key|
        send("#{key}=", options[key]) if options[key]
      end
      set_request_defaults(@sudo)
    end
  end
end