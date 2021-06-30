class Public::ShippingAddressController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def create
            @shipping_address = ShippingAddress.new(shipping_address_params)
            @shipping_address.customer_id = current_customer.id
        if  @shipping_address.save
            redirect_to shipping_address_index_path
            flash[:success] = "登録しました。"
        else
            @shipping_address = ShippingAddress.new
            @shipping_addresses = current_customer.shipping_addresses
            render 'index'
        end
  end

  def update
     shipping_address = ShippingAddress.find(params[:id])
     shipping_address.update(shipping_address_params)
     redirect_to shipping_address_index_path
  end

  def destroy
     shipping_address = ShippingAddress.find(params[:id])
     shipping_address.destroy
     redirect_to shipping_address_index_path
  end
  
  private
    def shipping_address_params
        params.require(:shipping_address).permit(:customer_id, :name, :postal_code, :address)
    end

end
