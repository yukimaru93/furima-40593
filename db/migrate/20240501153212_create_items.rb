class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string     :product_name,          null: false
      t.text       :product_description,   null: false
      t.integer    :item_category_id,      null: false
      t.integer    :item_status_id,        null: false
      t.integer    :charge_style_id,       null: false
      t.integer    :prefecture_id,         null: false
      t.integer    :shipping_date_id,      null: false
      t.integer    :price,                 null: false
      t.references :user,                  foreign_key: true, null: false

      t.timestamps
    end
  end
end
