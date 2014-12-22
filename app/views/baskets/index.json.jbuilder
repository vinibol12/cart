json.array!(@baskets) do |basket|
  json.extract! basket, :id
  json.url basket_url(basket, format: :json)
end
