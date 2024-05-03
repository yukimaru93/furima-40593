class ItemsController < ApplicationController
    before_action :authenticate_user!,except: [:index, :show]
    before_action :set_item, only: [:show, :edit, :update]
    before_action :move_to_index, only: [:edit, :update]

    def index
        @items = Item.includes(:user).order("created_at DESC")
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end


    def edit
    end

    def update
        if @item.update(item_params)
            redirect_to item_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def item_params
        params.require(:item).permit(:image,:product_name,:product_description,:item_category_id,:item_status_id,:charge_style_id,:prefecture_id,:shipping_date_id,:price).merge(user_id: current_user.id)
    end

    def set_item
        @item = Item.find(params[:id])
    end

    def move_to_index
        @user = @item.user
        unless current_user == @user
            redirect_to action: :index
        end
    end
end
