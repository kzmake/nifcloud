require 'niftycloud/version'

require 'niftycloud/error'

require 'niftycloud/configuration'
require 'niftycloud/request'
require 'niftycloud/api'
require 'niftycloud/client'

module Niftycloud
  # Alias for Niftycloud::Client.new
  #
  # @return [Niftycloud::Client]
  def self.client(options={})
    Niftycloud::Client.new(options)
  end
  
end
