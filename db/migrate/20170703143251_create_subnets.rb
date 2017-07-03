class CreateSubnets < ActiveRecord::Migration[5.0]
  def change
    create_table :subnets do |t|
      t.string :subnet
      t.string :mask
      t.string :description

      t.timestamps
    end
  end
end
