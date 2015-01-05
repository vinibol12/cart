class AddOrderToQueueGrocery < ActiveRecord::Migration
  def change
    add_reference :queue_groceries, :order, index: true
    add_foreign_key :queue_groceries, :orders
  end
end
