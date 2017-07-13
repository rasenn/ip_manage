class Ipaddress < ApplicationRecord
  belongs_to :subnet
  belongs_to :user, :optional => true

  def self.dispense(user_id, description ="")
    d = Ipaddress.where(user_id: -1).where(is_network: false).where(is_broadcast: false).first

    return nil unless d

    d.user_id = user_id
    d.description = description
    if d.save
      return d
    else
      return nil
    end
  end

  def refund(user_id)
    if self.user_id == user_id
      self.user_id = -1
      self.description = ""
      if self.save
        return true
      end
    end
    return false
  end
end
