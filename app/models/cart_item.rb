class CartItem < ActiveRecord::Base
  attr_accessible :product_id, :quantity

  belongs_to cart
end
