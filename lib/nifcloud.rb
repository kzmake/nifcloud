require 'nifcloud/version'
require 'nifcloud/objectified_hash'
require 'nifcloud/error'
require 'nifcloud/signature'
require 'nifcloud/configuration'
require 'nifcloud/request'
require 'nifcloud/api'
require 'nifcloud/client'

module Nifcloud
  extend Configuration

  def self.client(options={})
    Nifcloud::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name) || super
  end

  def self.http_proxy(address=nil, port=nil, username=nil, password=nil)
    Nifcloud::Request.set_proxy_config(address, port, username, password)
  end
end
