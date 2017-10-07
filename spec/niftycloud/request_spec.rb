require 'spec_helper'

RSpec.describe Niftycloud::Request do
  it { should respond_to :get }
  it { should respond_to :post }
  it { should respond_to :put }
  it { should respond_to :delete }
  before do
    @request = Niftycloud::Request.new
  end
end