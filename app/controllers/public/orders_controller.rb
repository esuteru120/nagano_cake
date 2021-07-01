class Public::OrdersController < ApplicationController
  def new
   @order = Order.new
	 @customer = current_customer
	 @addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def log
    @cart_items = current_customer.cart_items
    session[:order] = Order.new(order_params)
    @hoge = @cart_items.map {|cart_item|  cart_item.amount * cart_item.item.price }
    @hoge = @hoge.join.to_i
    @order = Order.new
    @order.shipping = 800
    if params[:order][:a_method] == "0"
     @order.postal_code
     @order.name
    elsif params[:order][:a_method] == "1"
     @order.id
    elsif params[:order][:a_method] == "2"
     @order.postal_code
     @order.address
     @order.name
    end
  end

  def create
      order = Order.new(order_params)
      order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
			order_detail = OrderDetail.new
			order_detail.item_id = cart_item.item_id
			order_detail.orders_id = orders_id
			order_detail.price = (cart_item.item.price * 1.1).floor
			order_detail.quantity = cart_item.quantity
			order_detail.making_status = 0
			rder_detail.created_at = created_at
			rder_detail.updated_at = updated_at
			order_detail.save
			end
			cart_items.destroy_all
  end
  
  def thanx
  end
  
  def index
    @orders = current_customer.orders
  end

  def show
  end
  
  private
  def shipping_address_params
      params.require(:shipping_address).permit(:customer_id, :name, :postal_code, :address)
  end
  def order_params
      params.require(:order).permit(:payment, :postal_code, :address, :name)
  end

end
 
