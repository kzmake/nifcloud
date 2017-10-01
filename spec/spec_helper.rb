require 'rspec'
require 'webmock/rspec'

require File.expand_path('../../lib/niftycloud', __FILE__)

RSpec.configure do |config|
  config.before(:all) do
    Niftycloud.endpoint = 'https://api.example.com'
    Niftycloud.private_token = 'secret'
  end
end

def load_fixture(name)
  File.new(File.dirname(__FILE__) + "/fixtures/#{name}.json")
end

# GET
def stub_get(path, fixture, status_code=200)
  stub_request(:get, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token }).
    to_return(body: load_fixture(fixture), status: status_code)
end

def a_get(path)
  a_request(:get, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token })
end

# POST
def stub_post(path, fixture, status_code=200)
  stub_request(:post, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token }).
    to_return(body: load_fixture(fixture), status: status_code)
end

def a_post(path)
  a_request(:post, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token })
end

# PUT
def stub_put(path, fixture)
  stub_request(:put, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token }).
    to_return(body: load_fixture(fixture))
end

def a_put(path)
  a_request(:put, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token })
end

# DELETE
def stub_delete(path, fixture)
  stub_request(:delete, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token }).
    to_return(body: load_fixture(fixture))
end

def a_delete(path)
  a_request(:delete, "#{Niftycloud.endpoint}#{path}").
    with(headers: { 'PRIVATE-TOKEN' => Niftycloud.private_token })
end
