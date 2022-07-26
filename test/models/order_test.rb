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

  test "Order fees should be calulated correctly" do
    small_order = Fabricate(:order, amount: 10)
    expected_small_fee = small_order.amount * 0.01 # 0.1€
    medium_order = Fabricate(:order, amount: 100)
    expected_medium_fee = medium_order.amount * 0.0095 # 0.95€
    large_order = Fabricate(:order, amount: 1000)
    expected_large_fee = large_order.amount * 0.0085  # 8.5€

    assert_equal small_order.fee, expected_small_fee
    assert_equal medium_order.fee, expected_medium_fee
    assert_equal large_order.fee, expected_large_fee
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

  test "within_last_week scope should work as expected" do
    Order.destroy_all
    complete_order = Fabricate(:order, completed_at: 10.days.ago)
    incomplete_order = Fabricate(:order, completed_at: nil )
    complete_and_within_week_order = Fabricate(:order)
    assert_equal 3, Order.count
    assert_equal 2, Order.complete.count
    assert Order.within_last_week(Time.now).include? complete_and_within_week_order
    assert_not Order.within_last_week(Time.now).include? incomplete_order
    assert_not Order.within_last_week(Time.now).include? complete_order
  end

  test "Complete? method should work as expected" do
    complete_order = Fabricate(:order)
    incomplete_order = Fabricate(:order, completed_at: nil )
    assert complete_order.complete?
    assert_not incomplete_order.complete?
  end

  test "Disbursed? method should work as expected" do
    disbursed_order = Fabricate(:order)
    non_disbursed_order = Fabricate(:order)
    Fabricate(:disbursement, merchant: disbursed_order.merchant)
    assert disbursed_order.disbursed?
    assert_not non_disbursed_order.disbursed?
  end
end
