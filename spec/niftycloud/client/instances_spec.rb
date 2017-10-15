require 'spec_helper'

describe Nifcloud::Client do
  describe ".instances" do
    context "Action: DescribeInstances" do
      before do
        allow(Time).to receive_message_chain(:now).and_return(Time.at(0))
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

    context "Action: DescribeInstanceAttribute" do
      before do
        allow(Time).to receive_message_chain(:now).and_return(Time.at(0))
        stub_get({Action: 'DescribeInstanceAttribute', InstanceId: 'test'})
        @instance = Nifcloud.DescribeInstanceAttribute(InstanceId: 'test')
      end

      it "should get the correct resource" do
        expect(a_get({Action: 'DescribeInstanceAttribute', InstanceId: 'test'})).to have_been_made
      end

      it "should return a response of instances" do
        expect(@instance).to be_a Nifcloud::ObjectifiedHash
        expect(@instance.instanceId).to eq("test")
        expect(@instance.instanceUniqueId).to eq("i-06xhrmv7")
      end
    end
  end
end
