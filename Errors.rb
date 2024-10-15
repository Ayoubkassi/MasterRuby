# here we will learn how to write customizable erroes for our ruby applictaion 

# raise , to raise exception just call it and rescue define and handle it 
# rescue by default take the StandardError by default 
# lets define our own error 

class CheckoutService::ItemNotAvailable < StandardError 

    def initialize(item_id:)
        super "Item #{item_id} is not available"
    end 

    def details 
        { item_id: @item_id }
    end 
end 

# now in our code we can add it easily , just recognize in which level th error happens 
# this is service 
class CheckoutService 

    def checkout!
        @user = @user.orders.build
        @user.cart.items.each do |item|
            raise ItemNotAvailable, item.id unless item.available?

            order.item.build(
                product: item.product,
                quantity: item.quantity
            )
        end 
    end 
end 


class CheckoutController < ApplicationController 

    def create 
        order = CheckoutService.new(
            user: current_user,
            payment_params: params[:payment]
        ).checkout!

        render json: { order: }, status: :created 

    rescue CheckoutService::ItemNotAvailable => e 
        render (
            json: { error: e.message, type: e.class.name },
            status: :uprocessable_entity
        )

    end 
end 