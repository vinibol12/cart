class ChangeIndexForQueueGgroceries < ActiveRecord::Migration
  def change
    rename_index :queue_groceries, :index_queue_groceries_on_cart_id, :index_queue_groceries_on_basket_id

  end
end
