require 'spec_helper'

describe Niftycloud do
  after {Niftycloud.reset}

  describe ".client" do
    it "should be a Niftycloud::Client" do
      expect(Niftycloud.client).to be_a Niftycloud::Client
    end

    it "should not override each other" do
      client1 = Niftycloud.client(endpoint: 'https://api1.example.com', secret_key: '001')
      client2 = Niftycloud.client(endpoint: 'https://api2.example.com', secret_key: '002')
      expect(client1.endpoint).to eq('https://api1.example.com')
      expect(client2.endpoint).to eq('https://api2.example.com')
      expect(client1.secret_key).to eq('001')
      expect(client2.secret_key).to eq('002')
    end
  end

  describe ".endpoint =" do
    it "should set endpoint" do
      Niftycloud.endpoint = 'https://api.example.com'
      expect(Niftycloud.endpoint).to eq('https://api.example.com')
    end
  end

  describe ".secret_key =" do
    it "should set secret_key" do
      Niftycloud.secret_key = 'secret'
      expect(Niftycloud.secret_key).to eq('secret')
    end
  end

  describe ".sudo =" do
    it "should set sudo" do
      Niftycloud.sudo = 'user'
      expect(Niftycloud.sudo).to eq('user')
    end
  end

  describe ".user_agent" do
    it "should return default user_agent" do
      expect(Niftycloud.user_agent).to eq(Niftycloud::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe ".user_agent =" do
    it "should set user_agent" do
      Niftycloud.user_agent = 'Custom User Agent'
      expect(Niftycloud.user_agent).to eq('Custom User Agent')
    end
  end

  describe ".configure" do
    Niftycloud::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set #{key}" do
        Niftycloud.configure do |config|
          config.send("#{key}=", key)
          expect(Niftycloud.send(key)).to eq(key)
        end
      end
    end
  end

  describe ".http_proxy" do
    it "delegates the method to Niftycloud::Request" do
      Niftycloud.endpoint = 'https://api.example.com'
      request = class_spy(Niftycloud::Request).as_stubbed_const

      Niftycloud.http_proxy('fazbearentertainment.com', 1987, 'ffazbear', 'itsme')
      expect(request).to have_received(:http_proxy).
          with('fazbearentertainment.com', 1987, 'ffazbear', 'itsme')
    end
  end
end

describe Niftycloud do
  it "has a version number" do
    expect(Niftycloud::VERSION).not_to be nil
  end
end
