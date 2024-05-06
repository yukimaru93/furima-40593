class Item < ApplicationRecord
    with_options presence: true do
        validates :image
        validates :product_name
        validates :product_description
        validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'is not a number'}
    end
    
    validates :item_category_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :item_status_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :charge_style_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :shipping_date_id, numericality: { other_than: 1, message: "can't be blank." }
    

    belongs_to :user
    has_one :buy
    has_one_attached :image

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :item_category
    belongs_to :item_status
    belongs_to :charge_style
    belongs_to :prefecture
    belongs_to :shipping_date
end
