module Niftycloud
  module Configuration
    VALID_OPTIONS_KEYS = [:endpoint, :private_token, :user_agent, :sudo, :httparty].freeze
    DEFAULT_USER_AGENT = "Niftycloud Ruby Gem #{Niftycloud::VERSION}".freeze
    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)
    # @private
    alias_method :auth_token=, :private_token=

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      self.endpoint       = ENV['NIFTYCLOUD_API_ENDPOINT']
      self.private_token  = ENV['NIFTYCLOUD_API_PRIVATE_TOKEN'] || ENV['NIFTYCLOUD_API_AUTH_TOKEN']
      self.httparty       = nil
      self.sudo           = nil
      self.user_agent     = DEFAULT_USER_AGENT
    end
  end
end