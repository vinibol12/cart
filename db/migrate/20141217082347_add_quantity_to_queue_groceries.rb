class AddQuantityToQueueGroceries < ActiveRecord::Migration
  def change
    add_column :queue_groceries, :quantity, :integer, default: 1
  end
end
