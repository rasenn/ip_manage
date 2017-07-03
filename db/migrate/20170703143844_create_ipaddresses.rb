class CreateIpaddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :ipaddresses do |t|
      t.integer :subnet_id
      t.string :ip_address
      t.boolean :is_gateway
      t.boolean :is_broadcast
      t.integer :state
      t.integer :owner_id
      t.date :expire_date

      t.timestamps
    end
  end
end
