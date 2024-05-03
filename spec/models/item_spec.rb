require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "出品機能" do
    context "出品ができるとき" do
      it ":product_name,:product_description,:item_category_id,:item_status_id,:charge_style_id,:prefecture_id,:shipping_date_id,:price,:user,:imageが存在していれば新規登録できる" do
        expect(@item).to be_valid
      end
    end

    context "出品ができないとき" do
      it "product_nameが空では出品できない" do
        @item.product_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end

      it "product_descriptionが空では出品できない" do
        @item.product_description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end

      it "item_category_idが空では出品できない" do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank.")
      end

      it "item_status_idが空では出品できない" do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank.")
      end

      it "charge_style_idが空では出品できない" do
        @item.charge_style_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge style can't be blank.")
      end

      it "prefecture_idが空では出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank.")
      end

      it "shipping_date_idが空では出品できない" do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank.")
      end

      it "priceが空では出品できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it "priceは全角では入力できない" do
        @item.price = "１２３４"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "priceは300円より低い値を設定できない" do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "priceは9999999円より高い値を設定できない" do
        @item.price = Faker::Number.between(from: 10000000, to: 99999999)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "imageが空では出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "ユーザーが紐づいていないと出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
