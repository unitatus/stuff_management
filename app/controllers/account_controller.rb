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
    flash[:notice] = "Item has NOT been added to cart, because that has not been coded yet."
    cart = Cart.find(:user_id => current_user.id)
    if (cart.nil?)
      cart = Cart.new
    end

    

    redirect_to :action => 'index'    
  end
end
