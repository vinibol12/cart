require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest

 fixtures :products # here we set our fixture to come into work when required
test "buying a product" do # set the test name
  QueueGrocery.delete_all # delete all QueueGrocecies items from db
  Order.delete_all  # delete all Order objects from db
  ruby_book = products(:ruby) # set the ruby fixture object as value of ruby_book

  get "/" #http method get to application root "/" means the root file set as index in the routes
  assert_response :success
  assert_template "index" #the view file passed to assert_template is passed as a string

  xml_http_request :post, '/queue_groceries', product_id: ruby_book.id #
  #xml_http_request(request_method, path,     parameters = nil, headers = nil) public
  #Performs an XMLHttpRequest request with the given parameters, mirroring a request
  # from the Prototype library.The request_method is :get, :post, :put, :delete or :head;
  # the parameters are nil, a hash, or a url-encoded or multipart string; the headers are
  # a hash. Keys are automatically upcased and prefixed with ‘HTTP_’ if not already.
  assert_response :success
  assert_template "_queue_grocery", "_basket"
  assert_template "create"




  post_via_redirect "/orders ", order: { name: "Vinicius",
                                         address: "25a Invermay ave",
                                         email: "vinibol12@yahoo.com.br",
                                         pay_type: "Check"}
  assert_response :success
  assert_template "index"
  basket = Basket.find(session[:basket_id])
  assert_equal 0, basket.queue_groceries.size

  orders = Order.all
  assert_equal 1, orders.size
  order = orders[0]

  assert_equal "Vinicius", order.name
  assert_equal "25a Invermay ave", order.address
  assert_equal "vinibol12@yahoo.com.br", order.email
  assert_equal "Check", order.pay_type

  assert_equal 1, order.queue_groceries.size
  queue_grocery = order.queue_groceries[0]
  assert_equal ruby_book, queue_grocery.product

  mail = ActionMailer::Base.deliveries.last
  assert_equal ["vinibol12@yahoo.com.br"], mail.to
  assert_equal 'Vinicius <vinisem@gmail.com>', mail[:from].value
  assert_equal "Pragmatic Store Order Confirmation", mail.subject
 end

end
