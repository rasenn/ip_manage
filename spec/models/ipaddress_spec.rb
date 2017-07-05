require 'rails_helper'

RSpec.describe Ipaddress, type: :model do
  describe "#dispense" do 
    context "have some blank ipaddress" do
      it "should be return ipaddress" do
        subnet = "192.168.1.0"
	mask = "24"
	description = "sample"
        Subnet.register(subnet,mask,description)
    	result = Ipaddress.dispense(1)
	expect(result).not_to eq false
	expect(result.class).to eq Ipaddress
      end
    end

    context "have no blank ipaddress" do
      it "should be return nil" do
        subnet = "192.168.1.0"
	mask = "30"
	description = "sample"
        Subnet.register(subnet,mask,description)
	expect(Ipaddress.all.size).to eq 4
    	result = Ipaddress.dispense(1)
	expect(result).not_to eq nil
	result = Ipaddress.dispense(1)
	expect(result).not_to eq nil
    	result = Ipaddress.dispense(1)
	expect(result).to eq nil
      end
    end
  end
end




