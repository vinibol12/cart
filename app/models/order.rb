class Order < ActiveRecord::Base

  has_many :queue_groceries, dependent: :destroy


  PAYMENT_TYPES = [ "Check", "Credit Card", "Purchase Order" ]

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_queue_groceries_from_basket(basket)
    #method that adds the groceries that are in the basket to the o
    # order.
    basket.queue_groceries.each do |item|
      item.basket_id = nil
      queue_groceries << item
      # seems like what this method is doing is basically dissossiate the
      # queue groceries from the basket they are related to to then
      # associate them to the order then this method is called in the
      # create action.
    end
  end

end

