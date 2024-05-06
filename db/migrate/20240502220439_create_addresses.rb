class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :post_number,              null: false
      t.integer :prefecture_id,           null: false
      t.string :locality,                 null: false
      t.string :house_number,             null: false
      t.string :building_name
      t.string :phone_number,             null: false
      t.references :buy,                  foreign_key: true, null: false
      t.timestamps
    end
  end
end
