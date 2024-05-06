class BuysController < ApplicationController
    before_action :item_find, only: [:index,:create]
    before_action :sell_out,only: [:index,:create]
    before_action :exit_buy,only: :index
    before_action :authenticate_user!

    def index
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        @buy_address = BuyAddress.new
    end


    def create
        @buy_address = BuyAddress.new(buy_address_params)
        if @buy_address.valid?
          pay_item
          @buy_address.save
          redirect_to root_path
        else
          gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
          render :index, status: :unprocessable_entity
        end
    end


    private
    def buy_address_params
        params.require(:buy_address).permit(:post_number, :prefecture_id, :locality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
    end

    def item_find
        @item = Item.find(params[:item_id])
    end


    def sell_out
        if @item.buy.presence
            redirect_to root_path
        end
    end

    def pay_item
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
        Payjp::Charge.create(
        amount: @item.price,  
        card: buy_address_params[:token],    
        currency: 'jpy'                 
        )
    end

    def exit_buy
        if current_user == @item.user
            redirect_to root_path
        end
    end
end
