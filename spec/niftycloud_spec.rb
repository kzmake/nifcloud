require 'spec_helper'

describe Nifcloud do
  after {Nifcloud.reset}

  describe ".client" do
    it "should be a Nifcloud::Client" do
      expect(Nifcloud.client).to be_a Nifcloud::Client
    end

    it "should not override each other" do
      client1 = Nifcloud.client(endpoint: 'https://api1.example.com', secret_key: '001')
      client2 = Nifcloud.client(endpoint: 'https://api2.example.com', secret_key: '002')
      expect(client1.endpoint).to eq('https://api1.example.com')
      expect(client2.endpoint).to eq('https://api2.example.com')
      expect(client1.secret_key).to eq('001')
      expect(client2.secret_key).to eq('002')
    end
  end

  describe ".endpoint =" do
    it "should set endpoint" do
      Nifcloud.endpoint = 'https://api.example.com'
      expect(Nifcloud.endpoint).to eq('https://api.example.com')
    end
  end

  describe ".secret_key =" do
    it "should set secret_key" do
      Nifcloud.secret_key = 'secret'
      expect(Nifcloud.secret_key).to eq('secret')
    end
  end

  describe ".user_agent" do
    it "should return default user_agent" do
      expect(Nifcloud.user_agent).to eq(Nifcloud::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe ".user_agent =" do
    it "should set user_agent" do
      Nifcloud.user_agent = 'Custom User Agent'
      expect(Nifcloud.user_agent).to eq('Custom User Agent')
    end
  end

  describe ".configure" do
    Nifcloud::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set #{key}" do
        Nifcloud.configure do |config|
          config.send("#{key}=", key)
          expect(Nifcloud.send(key)).to eq(key)
        end
      end
    end
  end

  describe ".http_proxy" do
    it "delegates the method to Nifcloud::Request" do
      Nifcloud.endpoint = 'https://api.example.com'
      request = class_spy(Nifcloud::Request).as_stubbed_const

      Nifcloud.http_proxy('hogefugapiyo.com', 8080, 'hoge', 'fuga')
      expect(request).to have_received(:set_proxy_config).
          with('hogefugapiyo.com', 8080, 'hoge', 'fuga')
    end
  end
end

describe Nifcloud do
  it "has a version number" do
    expect(Nifcloud::VERSION).not_to be nil
  end
end
