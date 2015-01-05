atom_feed do |feed|
  feed.title "Who bought #{@product.title}"
  feed.updated @latest_order.try(:updated_at)
  @products.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary type: xhtml do |xhtml|
        xhtml.p "Shipped to #{order.address}"
        xhtml.table do
          xhtml.tr do
            xhtml.td 'Product'
            xhtml.td 'Quantity'
            xhtml.td 'Total price'
          end
          order.queue_groceries.each do |item|
            xhtml item.product.title
            xhtml item.quantity
            xhtml item.number_to_currency item.total_price
          end
        end
        xhtml.tr do
          xhtml.th 'total', colspan: 2
          xhtml.number_to_currency \
            order.queue_groceries.map(&total_price.sum)
        end
      end
    xhtml.p "Paid by #{order.pay_type}"
    end
    entry.author do |author|
      author.name order.name
      author.email order.email
    end
  end
end



