class Product < ActiveRecord::Base
  has_many :queue_groceries
  has_many :orders, through: :queue_groceries

  before_destroy  :ensure_not_referenced_by_any_queue_grocery


def self.latest
  Product.order(:updated_at).last
end

#here we have the model for Product. It is the gate to the db so we can place here
  #methods that will validate the data entered in the forms. The method validates
  # receives commands here to make sure that there is a descriptio and a title
  # in each product created, to make sure that the title is unique and that the price
  # for each product is greater than 1 cent.
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, format: { with: %r{\.(gif|jpg|png)\Z}i, message: 'must be a valid format'}


  private

  #ensure that there is no queue groceries referencing this product

  def  ensure_not_referenced_by_any_queue_grocery

    if queue_groceries.empty?

      return true

    else
      errors.add(:base, 'Queue groceries present')

      return false
    end


  end

end
