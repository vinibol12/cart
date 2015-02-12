class Order < ActiveRecord::Base

  has_many :queue_groceries, dependent: :destroy


  PAYMENT_TYPES = [ "Check", "Credit Card", "Purchase Order" ]

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_queue_groceries_from_basket(basket)
    basket.queue_groceries.each do |item|
      item.basket_id = nil
      queue_groceries << item
    end
  end

end

