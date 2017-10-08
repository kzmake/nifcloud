require 'spec_helper'

describe Niftycloud::Client do
  describe ".instances" do
    context "Action: DescribeInstances" do
      before do
        stub_get("/", "DescribeInstances", "instances")
        @instances = Niftycloud.DescribeInstances
      end

      it "should get the correct resource" do
        expect(a_get("/", "DescribeInstances")).to have_been_made
      end

      it "should return a response of instances" do
        expect(@instances).to be_a Niftycloud::ObjectifiedHash
        expect(@instances.reservationSet[0].instancesSet[0].instanceId).to eq("test")
      end
    end
  end
end
