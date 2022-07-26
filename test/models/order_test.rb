require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "Order should belong to merchant" do
    order = Fabricate.build(:order, merchant: nil, shopper: Fabricate(:shopper))
    assert_not order.valid?
  end

  test "Order should belong to shopper" do
    order = Fabricate.build(:order, merchant: Fabricate(:merchant), shopper: nil)
    assert_not order.valid?
  end

  test "Order amount should be present" do
    order = Fabricate.build(:order, amount: nil)
    assert_not order.valid?
  end

  test "Order amount should be a number" do
    order = Fabricate.build(:order, amount: "1sd")
    assert_not order.valid?
  end

  test "Order amount should be >= 0" do
    order = Fabricate.build(:order, amount: -15)
    assert_not order.valid?
  end

  test "Order with valid attributes should be valid" do
    order = Fabricate.build(:order)
    assert order.valid?
  end

  test "Completed scope should work as expected" do
    Order.destroy_all
    complete_order = Fabricate(:order)
    incomplete_order = Fabricate(:order, completed_at: nil )
    assert_equal 2, Order.count
    assert_equal 1, Order.complete.count
    assert Order.complete.include? complete_order
    assert_not Order.complete.include? incomplete_order
  end
end
