class CombineGroceriesInBasket < ActiveRecord::Migration
  def up
    Basket.all.each do |basket|
      #first we create a loop to get all the baskets
      #then count the number of each product in the basket and set it locally as
      #sums

      sums = basket.queue_groceries.group(:product_id).sum(:quantity)
     #then we create another loop over each of the baskets using the id and quantity of each
      # product in the queue groceries as objects of the block passed to the loop
      sums.each do |product_id, quantity|
       # in case for certain product the quantity of queue groceries in the
        # basket is higher then 1 we have to delete them all to avoid those repetitions
        if quantity > 1
          #remove individual items
          basket.queue_groceries.where(product_id: product_id).delete_all
          #replace with a single item by passing to the block object basket
          # all the queue_groceries of certain product, calling it by id and
          #setting as value of grocery

          grocery = basket.queue_groceries.build(product_id: product_id)

          grocery.quantity= quantity
          # If I understand it right this sintax means that that we are passing to the column quantity
          #the number of certain queue_grocery in the Basket it is being the
          #grocery.quantity a call to the attribute quantity in the table and =quantity
          #the value in the block of the second loop, which is nothing but the sum of
          #all quantities from the column in first place.
          grocery.save
        end
      end
    end
  end

  def down
    #slip items with quantity >1  into multiple items
    QueueGrocery.where("quantity>1").each do |queue_grocery|
    #here we are finding in the table QueueGrocery all the objects that have a
      #quantity higher then 1 and setting as the block object queue_grocery

      #add individual items
      queue_grocery.quantity.times do
        # grab the number of items for each object and make times
        QueueGrocery.create basket_id: queue_grocery.basket_id, product_id: queue_grocery.product_id, quantity: 1
        # the integer result of that create a new QueueGrocery object that will have a basket_id of the one it was
        # referenced before and the product_id as well, with a quantity of one.
      end
      #remove original object that had multiple items
      queue_grocery.destroy
    end
  end
end
