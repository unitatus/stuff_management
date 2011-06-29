class AccountController < ApplicationController
  def index
  end

  def store_more_boxes
    @your_box_uninsured = Product.find(Rails.application.config.your_box_uninsured_product_id)
    @our_box_uninsured = Product.find(Rails.application.config.our_box_uninsured_product_id)
    @your_box_insured = Product.find(Rails.application.config.your_box_insured_product_id)
    @our_box_insured = Product.find(Rails.application.config.our_box_insured_product_id)

    @cart = Cart.find_by_user_id(current_user.id)
  end

  def order_boxes
    cart = Cart.find_by_user_id(current_user.id)
    if (cart.nil?)
      cart = Cart.new
      cart.user_id = current_user.id
    end

    convert_params

    if (params[:num_boxes_yours_uninsured] != "0") 
      cart = process_cart_item(cart, 
        Rails.application.config.your_box_uninsured_product_id, 
        params[:num_boxes_yours_uninsured])
    end

    if (params[:num_boxes_ours_uninsured] != "0") 
      cart = process_cart_item(cart, 
        Rails.application.config.our_box_uninsured_product_id, 
        params[:num_boxes_ours_uninsured])
    end

    if (params[:num_boxes_yours_insured] != "0") 
      cart = process_cart_item(cart, 
        Rails.application.config.your_box_insured_product_id, 
        params[:num_boxes_yours_insured])
    end

    if (params[:num_boxes_ours_insured] != "0") 
      cart = process_cart_item(cart, 
        Rails.application.config.our_box_insured_product_id, 
        params[:num_boxes_ours_insured])
    end

    if (cart.save())
      flash[:notice] = "Cart updated. Click the cart option on the left to see cart contents and finalize order."
    else
      flash[:alert] = "There was a problem saving your update to the cart."
    end

    redirect_to :action => 'index'    
  end

  def process_cart_item(cart, product_id, quantity)
    cart_item = cart.cart_items.select { |c| c.product_id == product_id }[0]

    if (!cart_item)
      cart_item = CartItem.new
      cart_item.product_id = product_id
      cart.cart_items << cart_item
    end

    cart_item.quantity = quantity

    cart
  end

  def convert_params()
    if (params[:num_boxes_yours_uninsured].empty?)
      params[:num_boxes_yours_uninsured] = "0"
    end
    
    if (params[:num_boxes_yours_insured].empty?)
      params[:num_boxes_yours_insured] = "0"
    end

    if (params[:num_boxes_ours_uninsured].empty?)
      params[:num_boxes_ours_uninsured] = "0"
    end

    if (params[:num_boxes_ours_insured].empty?)
      params[:num_boxes_ours_insured] = "0"
    end

    params
  end

  def cart
    @cart = Cart.find_by_user_id(current_user.id)
    if (@cart.nil?)
      @cart = Cart.new
    end
  end

  def update_cart_item
    if (params[:quantity] == '0')
      remove_cart_item
      return
    end

    cart_item = CartItem.find(params[:cart_item_id])

    cart_item.quantity = params[:quantity]

    if (cart_item.save())
      flash.now[:notice] = "Cart item quantity updated to #{cart_item.quantity}!"
    else
      flash.now[:alert] = "There was a problem saving your update."
      @errors = cart_item.errors
    end

    @cart = Cart.find(cart_item.cart_id)

    render 'cart'
  end

  def remove_cart_item
    # find the cart so we can re-show the page
    cart_item = CartItem.find(params[:cart_item_id])
   
    CartItem.delete(params[:cart_item_id])

    flash.now[:notice] = "Cart item removed."

    @cart = Cart.find(cart_item.cart_id)

    render 'cart'
  end

  def check_out
    @cart = Cart.find_by_user_id(current_user.id)
    @billing_address = Address.new
    @shipping_address = Address.new
    @credit_card = CreditCard.new
  end

  def finalize_check_out
    @cart = Cart.find_by_user_id(current_user.id)
    @credit_card = CreditCard.new
    @billing_address = Address.new

    @billing_address.first_name = params[:billing_first_name]
    @billing_address.last_name = params[:billing_last_name]
    @billing_address.day_phone = params[:billing_day_phone]
    @billing_address.evening_phone = params[:billing_evening_phone]
    @billing_address.address_line_1 = params[:billing_address_line_1]
    @billing_address.address_line_2 = params[:billing_address_line_2]
    @billing_address.city = params[:billing_address_city]
    @billing_address.state = params[:billing_address_state]
    @billing_address.zip = params[:billing_address_zip]

    if (params[:same_as_shipping][:same_as_shipping] == "1")
      @shipping_address = @billing_address
    else
      @shipping_address = Address.new

      @shipping_address.first_name = params[:shipping_first_name]
      @shipping_address.last_name = params[:shipping_last_name]
      @shipping_address.day_phone = params[:shipping_day_phone]
      @shipping_address.evening_phone = params[:shipping_evening_phone]
      @shipping_address.address_line_1 = params[:shipping_address_line_1]
      @shipping_address.address_line_2 = params[:shipping_address_line_2]
      @shipping_address.city = params[:shipping_address_city]
      @shipping_address.state = params[:shipping_address_state]
    end

    # holding off on saving until debugged and fully functional
    if (!@billing_address.valid? || !@shipping_address.valid?)
      render 'check_out'
      return
    end
  end
end
