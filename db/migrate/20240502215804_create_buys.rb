class CreateBuys < ActiveRecord::Migration[7.0]
  def change
    create_table :buys do |t|
      t.references :user,                  foreign_key: true, null: false
      t.references :item,                  foreign_key: true, null: false
      t.timestamps
    end
  end
end
