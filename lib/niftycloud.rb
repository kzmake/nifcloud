require 'niftycloud/version'
require 'niftycloud/page_links'
require 'niftycloud/objectified_hash'
require 'niftycloud/paginated_response'
require 'niftycloud/error'
require 'niftycloud/signature'
require 'niftycloud/configuration'
require 'niftycloud/request'
require 'niftycloud/api'
require 'niftycloud/client'

module Niftycloud
  extend Configuration

  def self.client(options={})
    Niftycloud::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name) || super
  end

  def self.http_proxy(address=nil, port=nil, username=nil, password=nil)
    Niftycloud::Request.http_proxy(address, port, username, password)
  end

  def self.actions
    hidden = /endpoint|secret_access_key|auth_token|user_agent|sudo|get|post|put|\Adelete\z|validate|set_request_defaults|httparty/
    (Niftycloud::Client.instance_methods - Object.methods).reject { |e| e[hidden] }
  end
end
