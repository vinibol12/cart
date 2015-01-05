class QueueGrocery < ActiveRecord::Base

  belongs_to :order
  belongs_to :product
  belongs_to :basket



  def decrement_one
    if self.quantity > 1
      self.quantity -= 1
    else
      self.destroy
    end
    self

  end

  def total_price
    product.price * quantity
  end
end
