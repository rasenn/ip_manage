class Ipaddress < ApplicationRecord
  belongs_to :subnet

  def self.dispense(user_id)
    d = Ipaddress.where(owner_id: nil).where(is_network: false).where(is_broadcast: false).first

    return nil unless d

    d.owner_id = user_id
    if d.save
      return d
    else
      return nil
    end

  end

end
