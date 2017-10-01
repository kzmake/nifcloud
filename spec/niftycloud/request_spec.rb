require 'spec_helper'

RSpec.describe Niftycloud::Request do
  it { should respond_to :get }
  it { should respond_to :post }
  it { should respond_to :put }
  it { should respond_to :delete }
  before do
    @request = Niftycloud::Request.new
  end

  describe "#set_authorization_header" do
    it "should raise MissingCredentials when auth_token and private_token are not set" do
      expect do
        @request.send(:set_authorization_header, {})
      end.to raise_error(Niftycloud::Error::MissingCredentials)
    end

    it "should set the correct header when given a private_token" do
      @request.private_token = 'secret'
      expect(@request.send(:set_authorization_header, {})).to eq("PRIVATE-TOKEN" => 'secret')
    end

    it "should set the correct header when given a private_token" do
      @request.private_token = 'ys9BtunN3rDKbaJCYXaN'
      expect(@request.send(:set_authorization_header, {})).to eq("PRIVATE-TOKEN" => 'ys9BtunN3rDKbaJCYXaN')
    end

    it "should set the correct header when setting an auth_token via the private_token config option" do
      @request.private_token = '3225e2804d31fea13fc41fc83bffef00cfaedc463118646b154acc6f94747603'
      expect(@request.send(:set_authorization_header, {})).to eq("Authorization" => "Bearer 3225e2804d31fea13fc41fc83bffef00cfaedc463118646b154acc6f94747603")
    end
  end
end