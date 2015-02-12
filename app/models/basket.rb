class Basket < ActiveRecord::Base
  has_many :queue_groceries, dependent: :destroy

  def total_price
    queue_groceries.to_a.sum { |grocery| grocery.total_price}
  end
  def add_product(product_id)

    current_item = queue_groceries.find_by(product_id: product_id)

    if current_item
      current_item.quantity += 1

    else
      current_item = queue_groceries.build(product_id: product_id)

    end
    current_item
  end
end
