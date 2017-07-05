require 'rails_helper'

RSpec.describe Subnet, type: :model do
  describe "#register" do 
    context "add collect subnet" do
      it "should be success" do
        subnet = "192.168.1.0"
	mask = "24"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	expect(Subnet.find(1).subnet).to eq subnet
	expect(Subnet.find(1).mask).to eq mask
	expect(Ipaddress.all.size).to eq 256
	expect(result).to eq true

	ipa = Ipaddress.order("id").all
	expect(ipa[0].is_network).to be true
	expect(ipa[0].is_broadcast).to be false

	expect(ipa[1].is_network).to be false
	expect(ipa[1].is_broadcast).to be false
#	binding.pry
	expect(ipa[-1].is_broadcast).to be true
	expect(ipa[-1].is_network).to be false
      end
    end

    context "mask 30" do
      it "should be success" do
        subnet = "192.168.1.0"
	mask = "30"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	expect(Subnet.find(1).subnet).to eq subnet
	expect(Subnet.find(1).mask).to eq mask
	expect(Ipaddress.all.size).to eq 4
	expect(result).to eq true
      end
      
    end



    context "add incollect subnet" do 
      it "should be fail and not create ipadresses #1" do
        subnet = "192.168.1.a"
	mask = "24"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	expect(result).to eq false
	expect(Ipaddress.all.size).to eq 0
      end    

      it "should be fail and not create ipadresses #2" do
        subnet = "192.168.1.300"
	mask = "24"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	expect(result).to eq false
	expect(Ipaddress.all.size).to eq 0
      end    

      it "should be fail and not create ipadresses #3" do
        subnet = "192.168.1.0"
	mask = "0"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	expect(result).to eq false
	expect(Ipaddress.all.size).to eq 0
      end    

      it "should be fail and not create ipadresses #4" do
        subnet = "192.168.1.0"
	mask = "33"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	expect(result).to eq false
	expect(Ipaddress.all.size).to eq 0
      end    



    end
  end

  describe "#unregister" do 
    context "registered" do
      it "should be success" do
        subnet = "192.168.1.0"
	mask = "24"
	description = "sample"
        result = Subnet.register(subnet,mask,description)
	sub = (Subnet.all)[0]
	expect(sub.ipaddresses.size).to be 256
	expect(Subnet.all.count).to eq 1

	sub.unregister
	expect(sub.ipaddresses.size).to be 0
	expect(Subnet.all.count).to eq 0
	
	
      end
    end
  end

end




