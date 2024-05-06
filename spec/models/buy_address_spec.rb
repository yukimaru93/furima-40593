require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user: user)
    @buy_address = FactoryBot.build(:buy_address, user_id: user.id, item_id: item.id)
  end
  describe "購入情報の保存" do

    context "内容に問題ない場合" do
      it "すべての値が正しく入力されていれば保存できること" do
        expect(@buy_address).to be_valid
      end
      it "building_nameは空でも保存できること" do
        @buy_address.building_name = ""
        expect(@buy_address).to be_valid
      end
    end

    context "内容に問題がある場合" do
      it "post_numberが空だと保存できないこと" do
        @buy_address.post_number = ""
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Post number can't be blank")
      end
      it "post_numberが半角のハイフンを含んだ正しい形式でないと保存できないこと" do
        @buy_address.post_number = "1234567"
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end
      it "prefectureを選択していないと保存できないこと" do
        @buy_address.prefecture_id = 1
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Prefecture can't be blank.")
      end
      it "localityが空だと保存できないこと" do
        @buy_address.locality = ""
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Locality can't be blank")
      end
      it "house_numberが空だと保存できないこと" do
        @buy_address.house_number = ""
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("House number can't be blank")
      end
      it "phone_numberが空では保存できないこと" do
        @buy_address.phone_number = ""
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberは12桁以上では保存できないこと" do
        @buy_address.phone_number = Faker::Number.leading_zero_number(digits: 12)
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number is invalid. Input half-width number.")
      end
      it "phone_numberは9桁以下では保存できないこと" do
        @buy_address.phone_number = Faker::Number.leading_zero_number(digits: 9)
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number is invalid. Input half-width number.")
      end
      it "phone_numberは半角数字以外では保存できないこと" do
        @buy_address.phone_number = "あaA亜ア００００００００"
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number is invalid. Input half-width number.")
      end
      it "userが紐づいていないと保存できないこと" do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐付いていないと保存できないこと" do
        @buy_address.item_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが存在しないと保存できないこと" do
        @buy_address.token = ""
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
