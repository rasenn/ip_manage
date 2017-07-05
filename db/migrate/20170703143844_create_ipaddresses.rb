class CreateIpaddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :ipaddresses do |t|
      t.belongs_to :subnet, index: true 
      t.string  :ip_address
      t.boolean :is_network, default: false, null: false
      t.boolean :is_broadcast, default: false, null: false
      t.integer :state
      t.integer :owner_id, default: -1
      t.string  :description

      t.timestamps
    end

    add_index :ipaddresses, :ip_address, :unique => true
#    add_index :ipaddresses, :subnet_id
    add_index :ipaddresses, :owner_id
    add_index :ipaddresses, :state


  end
end
