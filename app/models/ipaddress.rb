class Ipaddress < ApplicationRecord
  belongs_to :subnet

  def self.dispense(user_id, description ="")
    d = Ipaddress.where(owner_id: nil).where(is_network: false).where(is_broadcast: false).first

    return nil unless d

    d.owner_id = user_id
    d.description = description
    if d.save
      return d
    else
      return nil
    end
  end

  def refund(user_id)
    if self.owner_id == user_id
      self.owner_id = -1
      if self.save
        return true
      end
    end
    return false
  end
end
