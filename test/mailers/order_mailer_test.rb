require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Store Order Confirmation", mail.subject
    assert_equal [ENV["GMAIL_USERNAME"]], mail.to
    assert_equal [ENV["GMAIL_USERNAME"]], mail.from
    assert_match /1 x Yahboom Professional Raspberry Pi Tank Smart Robot Kit/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Store Order Shipped", mail.subject
    assert_equal [ENV["GMAIL_USERNAME"]], mail.to
    assert_equal [ENV["GMAIL_USERNAME"]], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/,
    mail.body.encoded
  end

end
