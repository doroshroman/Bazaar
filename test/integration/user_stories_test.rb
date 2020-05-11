require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  include ActiveJob::TestHelper
  
  test "buying a product" do
    start_order_count = Order.count
    robot = products(:robot)

    get "/"
    assert_response :success
    assert_select 'h1', "Your Catalog"

    post '/line_items', params: { product_id: robot.id }, xhr: true
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal robot, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_select 'legend', 'Please Enter Your Details'

    perform_enqueued_jobs do
      post "/orders", params: {
        order: {
          name: "Roman Dorosh",
          address: "123 The Street",
          email: ENV["GMAIL_USERNAME"],
          pay_type: "Check"
       }
      }
    
    follow_redirect!

    assert_response :success
    assert_select 'h1', "Your Catalog"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    assert_equal start_order_count + 1, Order.count
    order = Order.last

    assert_equal "Roman Dorosh", order.name
    assert_equal "123 The Street", order.address
    assert_equal ENV["GMAIL_USERNAME"], order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal robot, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal [ENV["GMAIL_USERNAME"]], mail.to
    assert_equal ENV["GMAIL_USERNAME"], mail[:from].value
    assert_equal "Store Order Confirmation", mail.subject
    end
  end
end
