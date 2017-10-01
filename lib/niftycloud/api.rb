module Niftycloud
  class API < Request
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    alias_method :auth_token=, :private_token=

    def initialize(options={})
      options = Niftycloud.options.merge(options)
      (Configuration::VALID_OPTIONS_KEYS + [:private]).each do |key|
        send("#{key}=", options[key]) if options[key]
      end
      set_request_defaults(@sudo)
    end
  end
end