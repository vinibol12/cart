class PaymentType < ActiveRecord::Base

  def self.names
    #here we have a class method self.names which means this method can be called on the class directly
  all.collect{ |payment_type| payment_type.name}
    #this statement calls the method collect on all which calls all the objects of the class and receives
    # a block. The block object payment_type then has all the instances of the class and once .name is called
    #upon it, the result of that is gonna be the value of each object in the name column of the payment_type class

  end


  validates_each :pay_type do |model, attr, value|
    #here we validate the pay_type field for the form. again we have a block with 3 objects.
    #from now I'm lost. Need help to figure out how the three blocck objects interact in the rest
    #of the method.
    if !PaymentType.names.include?(value)
    model.errors.add(attr, "Payment type not in the list")
  #in this
    end
  end
end
