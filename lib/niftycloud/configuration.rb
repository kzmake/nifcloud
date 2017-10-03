module Niftycloud
  module Configuration
    VALID_OPTIONS_KEYS = [:endpoint, :secret_access_key, :user_agent, :sudo, :httparty].freeze
    DEFAULT_USER_AGENT = "Niftycloud Ruby Gem #{Niftycloud::VERSION}".freeze
    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    alias_method :auth_token=, :secret_access_key=

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    def reset
      self.endpoint           = ENV['NIFTYCLOUD_API_ENDPOINT']
      self.secret_access_key  = ENV['NIFTYCLOUD_API_SECRET_ACCESS_KEY'] || ENV['NIFTYCLOUD_API_AUTH_TOKEN']
      self.httparty           = nil
      self.sudo               = nil
      self.user_agent         = DEFAULT_USER_AGENT
    end
  end
end