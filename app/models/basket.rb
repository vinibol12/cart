class Basket < ActiveRecord::Base
  has_many :queue_groceries, dependent: :destroy
#we are now implementiing our Basket to make it smarter by being able to count
  #the items of a same product and carry quantity in the view instead of dilplaying
  #this huge list of repeated items.
  #we first generated a new column quantity in the table queue_groceries

  def total_price
    queue_groceries.to_a.sum { |grocery| grocery.total_price}
  end
  def add_product(product_id)
    # now we  create the method add_product which will receive a paramether
    #with the id of the product we are adding

    current_item = queue_groceries.find_by(product_id: product_id)
    #retrieve the product from the database with the id and set as current_item
    #we build the relationship from the product we want and the queue groceries first
    #using the product's id and passing this to current_item. With this we are saying
    #that queue_groceries has a product and that is being held by the local variable
    #current_item now

    if current_item
      # if we already have a current_item object
      current_item.quantity += 1

      #when called, the method add_product will increment the count by one
    else
      current_item = queue_groceries.build(product_id: product_id)
      #in case we dont have it it will build a new queue_grocery object

    end
    current_item
    # in the end the method add_product will return us the the content of current_item
  end
end
