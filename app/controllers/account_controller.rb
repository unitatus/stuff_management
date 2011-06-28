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
    cart_item = CartItem.find(params[:cart_item_id])

    cart_item.quantity = params[:quantity]

    if (cart_item.save())
      flash[:notice] = "Cart item updated!"
    else
      flash[:alert] = "There was a problem saving your update."
      @errors = cart_item.errors
    end

    redirect_to :action => 'cart'
  end
end
