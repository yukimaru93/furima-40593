class BuyAddress
    include ActiveModel::Model
    attr_accessor :user_id,:item_id,:post_number,:prefecture_id,:locality,:house_number,:building_name,:phone_number,:token

    with_options presence: true do
        validates :post_number, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
        validates :locality
        validates :house_number
        validates :phone_number, format: {with: /\A[0-9\d]{10,11}\Z/,message: "is invalid. Input half-width number." }
        validates :user_id
        validates :item_id
        validates :token
    end

    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank." }

    

    def save
        buy = Buy.create(user_id: user_id, item_id: item_id)
        Address.create(post_number: post_number, prefecture_id: prefecture_id, locality: locality, house_number: house_number, building_name: building_name, phone_number: phone_number, buy_id: buy.id)
    end
end