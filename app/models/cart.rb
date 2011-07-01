# == Schema Information
# Schema version: 20110627180233
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Cart < ActiveRecord::Base
  has_many :cart_items, :autosave => true
  has_one :order

  def estimated_total
    total_estimate = 0

    cart_items.each do |cart_item|
      product = Product.find(cart_item.product_id)

      total_estimate += (cart_item.quantity * product.price)
    end
 
    total_estimate
  end

  def get_quantity(product_id)
    found_cart_items = cart_items.select { |c| c.product_id == product_id }

    total_qty = 0

    found_cart_items.each do |c|
      total_qty += c.quantity
    end

    total_qty
  end

  def mark_ordered
    status = "ordered"
    ordered_at = Time.now
  end
end
