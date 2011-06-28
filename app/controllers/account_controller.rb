class AccountController < ApplicationController
  def index
  end

  def store_more_boxes
    @your_box = Product.find(Rails.application.config.your_box_product_id)
    @our_box = Product.find(Rails.application.config.our_box_product_id)
    @your_box_insurance = Product.find(Rails.application.config.your_box_insurance_product_id)
    @our_box_insurance = Product.find(Rails.application.config.our_box_insurance_product_id)
    @your_box_inventorying = Product.find(Rails.application.config.your_box_inventorying_product_id)
    @our_box_inventorying = Product.find(Rails.application.config.our_box_inventorying_product_id)
  end

  def order_boxes
    cart = Cart.find_by_user_id(current_user.id)
    if (cart.nil?)
      cart = Cart.new
      cart.user_id = current_user.id
    end

    # logic to check for form submission -- probably part of Rails

    cart_changes = false

    if (!params[:num_boxes_yours].empty?) 
      new_product = Product.find(Rails.application.config.your_box_product_id)
      cart_item = CartItem.new
      cart_item.product_id = new_product.id
      cart_item.quantity = params[:num_boxes_yours]
      cart.cart_items << cart_item
      cart_changes = true
    end

    if (!params[:num_boxes_ours].empty?) 
      new_product = Product.find(Rails.application.config.our_box_product_id)
      cart_item = CartItem.new
      cart_item.product_id = new_product.id
      cart_item.quantity = params[:num_boxes_ours]
      cart.cart_items << cart_item
      cart_changes = true
    end

    if (!params[:num_boxes_yours_insured].empty?) 
      new_product = Product.find(Rails.application.config.your_box_insurance_product_id)
      cart_item = CartItem.new
      cart_item.product_id = new_product.id
      cart_item.quantity = params[:num_boxes_yours_insured]
      cart.cart_items << cart_item
      cart_changes = true
    end

    if (!params[:num_boxes_ours_insured].empty?) 
      new_product = Product.find(Rails.application.config.our_box_insurance_product_id)
      cart_item = CartItem.new
      cart_item.product_id = new_product.id
      cart_item.quantity = params[:num_boxes_ours_insured]
      cart.cart_items << cart_item
      cart_changes = true
    end

    if (cart_changes)
      if (cart.save())
        flash[:notice] = "Items were added to your cart! Click the cart option on the left to see cart contents and finalize order."
      else
        flash[:alert] = "There was a problem saving your order to the cart!"
      end
    end

    redirect_to :action => 'index'    
  end

  def cart
    @cart = Cart.find_by_user_id(current_user.id)
    if (@cart.nil?)
      @cart = Cart.new
    end
  end

  def update_cart_item
    @cart = Cart.find(params[:cart_id])
    cart_item = @cart.cart_items.select {|c| c.id = params[:cart_item_id]}[0]

    cart_item.quantity = params[:quantity]

    if (cart_item.save())
      flash.now[:notice] = "Cart item quantity updated to #{cart_item.quantity}!"
    else
      flash.now[:alert] = "There was a problem saving your update."
      @errors = cart_item.errors
      @cart = Cart.find(params[:cart_id])
    end

    render 'cart'
  end

  def remove_cart_item
    # find the cart so we can re-show the page
    cart_item = CartItem.find(params[:cart_item_id])
    @cart = Cart.find(cart_item.cart_id)
   
    CartItem.delete(params[:cart_item_id])

    flash.now[:notice] = "Cart item removed."

    render 'cart'
  end
end
