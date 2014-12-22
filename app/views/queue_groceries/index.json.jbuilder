json.array!(@queue_groceries) do |queue_grocery|
  json.extract! queue_grocery, :id, :product_id, :basket_id
  json.url queue_grocery_url(queue_grocery, format: :json)
end
