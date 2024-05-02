require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "新規登録" do
    context "新規登録ができるとき" do
      it "nickname,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birth_dayが存在していれば新規登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録ができないとき" do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailには@が必要である" do
        @user.email = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "同じemailは使えない" do
        @user.save
        anothor_user = FactoryBot.build(:user)
        anothor_user.email = @user.email
        anothor_user.valid?
        expect(anothor_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 180)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "123456"
        @user.password_confirmation = "098765"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "last_nameが空では登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "last_nameは全角で入力しなければ登録できない" do
        test = ["a","A","@"]
        test.each do |t|
          @user.last_name = t
          unless @user.valid?
            expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.")
          end
        end
      end

      it "first_nameは全角で入力しなければ登録できない" do
        test = ["a","A","@"]
        test.each do |t|
          @user.first_name = t
          unless @user.valid?
            expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
          end
        end
      end

      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it "last_name_kanaは全角カタカナで入力しなければ登録できない" do
        test = ["a","A","あ","亜","@"]
        test.each do |t|
          @user.last_name_kana = t
          unless @user.valid?
            expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters.")
          end
        end
      end

      it "first_name_kanaは全角カタカナで入力しなければ登録できない" do
        test = ["a","A","あ","亜","@"]
        test.each do |t|
          @user.first_name_kana = t
          unless @user.valid?
            expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters.")
          end
        end
      end

      it "birth_dayが空では登録できない" do
        @user.birth_day = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end

end
