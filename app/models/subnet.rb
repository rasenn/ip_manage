require 'ipaddr'

class Subnet < ApplicationRecord
  has_many :ipaddresses, dependent: :destroy

  
  ## 192.168.1.1/24の形式のみ受け付ける。
  def self.register(subnet, mask, description)
    # maskが0 or 数字以外の場合はfalse
    return false if mask.to_i == 0

    begin
#      binding.pry
      sub = IPAddr.new(subnet.to_s + "/" + mask.to_s)

      # ipv4でなければfalseを返す。
      return false unless sub.ipv4?

      sub_size = 2 ** ( 32 - mask.to_i ) 
      
      # トランザクション開始
      ActiveRecord::Base.transaction do
        # subnet登録
	reg_sub = Subnet.new(:subnet => subnet.to_s, :mask => mask.to_s, :description => description.to_s)
      	reg_sub.save!

	counter = 0

        # ip登録
        sub.to_range.each do |ip|
	  is_network = (counter == 0)
	  is_broadcast = (counter == ( sub_size -1 ))
          reg_ip = Ipaddress.new(:subnet_id => reg_sub.id, 
                        :ip_address => ip.to_s, :is_network => is_network,
	  	        :is_broadcast => is_broadcast, :state => -1 )
	  reg_ip.save!

	  counter += 1
        end
      end
    rescue => e
    # IPアドレス/サブネットマスクがおかしい場合
      p e
      return false
    end

    return true      
  end

  def unregister
    self.destroy
  end

end
