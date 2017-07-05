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

  describe "#refund" do 
    context "have ip ipaddress have collect owner_id" do
      it "should be refund ipaddress" do
        subnet = "192.168.1.0"
	mask = "24"
	description = "sample"
        Subnet.register(subnet,mask,description)
    	Ipaddress.dispense(1)
	ipa = Ipaddress.where(owner_id: 1).first
	expect(ipa.owner_id).to eq 1
	id = ipa.id
	result = ipa.refund(1)
	expect(result).to eq true
	ipa = Ipaddress.where(id: id).first
	expect(ipa.owner_id).to eq -1
      end
    end

    context "have ip ipaddress have incollect owner_id" do
      it "should not be refund ipaddress" do
        subnet = "192.168.1.0"
	mask = "24"
	description = "sample"
        Subnet.register(subnet,mask,description)
    	Ipaddress.dispense(1)
	ipa = Ipaddress.where(owner_id: 1).first
	expect(ipa.owner_id).to eq 1
	id = ipa.id
	result = ipa.refund(2)
	expect(result).to eq false
	ipa = Ipaddress.where(id: id).first
	expect(ipa.owner_id).to eq 1
      end
    end

  end

end




