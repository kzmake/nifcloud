require 'spec_helper'

describe Nifcloud::Client do
  describe ".instances" do
    context "Action: DescribeInstances" do
      before do
        stub_get({Action: 'DescribeInstances'})
        @instances = Nifcloud.DescribeInstances
      end

      it "should get the correct resource" do
        expect(a_get({Action: 'DescribeInstances'})).to have_been_made
      end

      it "should return a response of instances" do
        expect(@instances).to be_a Nifcloud::ObjectifiedHash
        expect(@instances.reservationSet[0].instancesSet[0].instanceId).to eq("test")
      end
    end
  end
end
