class CreateQueueGroceries < ActiveRecord::Migration
  def change
    create_table :queue_groceries do |t|
      t.references :product, index: true
      t.belongs_to :cart, index: true

      t.timestamps
    end
  end
end
