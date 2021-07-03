class Public::OrdersController < ApplicationController
  def new
   @order = Order.new
	 @customer = current_customer
	 @addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def log
    @cart_items = current_customer.cart_items
    @hoge = @cart_items.map {|cart_item|  cart_item.amount * cart_item.item.price }
    @hoge = @hoge.join.to_i
    @order = Order.new(order_params)
    @order.payment = params[:order][:payment].to_i
    @order.customer_id = current_customer.id
    @order.shipping = 800
    
    if params[:order][:a_method] == "0"
     @order.postal_code = current_customer.postal_code
     @order.address = current_customer.address
     @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:a_method] == "1"
     @shipping_address = ShippingAddress.find(params[:order][:shipping_address_for_order])
     @order.postal_code = @shipping_address.postal_code
     @order.address = @shipping_address.address
     @order.name = @shipping_address.name
    end
    session[:order] = Order.new
    session[:order][:payment] = @order.payment
    session[:order][:customer_id] = @order.customer_id
    session[:order][:shipping] = @order.shipping
    session[:order][:postal_code] = @order.postal_code
    session[:order][:address] = @order.address
    session[:order][:name] = @order.name
    #binding.pry
  end

  def create
      order = Order.new(session[:order])
      order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
			order_detail = OrderDetail.new
			order_detail.item_id = cart_item.item_id
			order_detail.order_id = order.id
			order_detail.price = (cart_item.item.price * 1.1).floor
			order_detail.quantity = cart_item.amount
			order_detail.making_status = 0
			order_detail.save
			end
			cart_items.destroy_all
			redirect_to orders_thanx_path
  end
  
  def thanx
  end
  
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
		@order_details = @order.order_details
	
		
  end
  
  private
  def shipping_address_params
      params.require(:shipping_address).permit(:customer_id, :name, :postal_code, :address)
  end
  def order_params
      params.require(:order).permit(:postal_code, :address, :name)
  end

end
 
