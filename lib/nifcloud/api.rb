module Nifcloud
  class API < Request
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Nifcloud.options.merge(options)
      (Configuration::VALID_OPTIONS_KEYS + [:secret_key]).each do |key|
        send("#{key}=", options[key]) if options[key]
      end

      super
    end
  end
end
