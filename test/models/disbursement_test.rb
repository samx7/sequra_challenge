# frozen_string_literal: true

require 'test_helper'

class DisbursementTest < ActiveSupport::TestCase
  test 'Disbursement should belong to merchant' do
    disbursement = Fabricate.build(:disbursement, merchant: nil)
    assert_not disbursement.valid?
  end

  test 'Disbursement date should be present' do
    disbursement = Fabricate.build(:disbursement, date: nil)
    assert_not disbursement.valid?
  end

  test 'Disbursement should have orders through merchant' do
    merchant = Fabricate(:merchant)
    order = Fabricate(:order, merchant: merchant)
    disbursement = Fabricate(:disbursement, merchant: merchant)
    assert_equal disbursement.merchant, merchant
    assert disbursement.orders.include?(order)
  end

  test 'Disbursement by week scope works as expected' do
    new_disbursement = Fabricate(:disbursement)
    old_disbursement = Fabricate(:disbursement, date: 2.weeks.ago)

    assert new_disbursement.date > (Time.zone.now.beginning_of_week) && new_disbursement.date <= (Time.zone.now.end_of_week)
    assert_not old_disbursement.date > (Time.zone.now.beginning_of_week) && old_disbursement.date <= (Time.zone.now.end_of_week)

    assert_equal 2, Disbursement.count
    assert_equal 1, Disbursement.by_week(Time.zone.now).count
    assert_includes Disbursement.by_week(Time.zone.now), new_disbursement
    assert_not Disbursement.by_week(Time.zone.now).include?(old_disbursement)
  end

  test 'Disbursement viable_orders should work as expected' do
    merchant = Fabricate(:merchant)
    complete_order = Fabricate(:order, completed_at: 10.days.ago, merchant: merchant)
    incomplete_order = Fabricate(:order, completed_at: nil, merchant: merchant)
    complete_and_within_week_order = Fabricate(:order, merchant: merchant)

    travel 1.hour
    disbursement = Fabricate(:disbursement, merchant: merchant)

    assert_equal 1, disbursement.viable_orders.size
    assert_equal disbursement.viable_orders.first, complete_and_within_week_order
    assert_includes disbursement.viable_orders, complete_and_within_week_order
    assert_not disbursement.viable_orders.include?(incomplete_order)
    assert_not disbursement.viable_orders.include?(complete_order)
  end

  test 'Disbursement total amount should be calculated correctly' do
    merchant = Fabricate(:merchant)
    order1 = Fabricate(:order, completed_at: 5.days.ago, merchant: merchant, amount: 10)
    order2 = Fabricate(:order, completed_at: 3.days.ago, merchant: merchant, amount: 100)
    order3 = Fabricate(:order, completed_at: 2.days.ago, merchant: merchant, amount: 1000)
    disbursement = Fabricate(:disbursement, merchant: merchant)

    expected_amount = order1.amount + order2.amount + order3.amount

    assert_equal 3, disbursement.viable_orders.size
    assert_equal disbursement.total_amount, expected_amount
  end

  test 'Disbursement fee should be calculated correctly' do
    merchant = Fabricate(:merchant)
    order1 = Fabricate(:order, completed_at: 5.days.ago, merchant: merchant, amount: 10)
    order2 = Fabricate(:order, completed_at: 3.days.ago, merchant: merchant, amount: 100)
    order3 = Fabricate(:order, completed_at: 2.days.ago, merchant: merchant, amount: 1000)
    disbursement = Fabricate(:disbursement, merchant: merchant)

    expected_fee = order1.fee + order2.fee + order3.fee

    assert_equal 3, disbursement.viable_orders.size
    assert_equal disbursement.fee, expected_fee
  end

  test 'Amount should be calculated before saving' do
    Order.destroy_all
    merchant = Fabricate(:merchant)
    order1 = Fabricate(:order, completed_at: 5.days.ago, merchant: merchant, amount: 10)
    order2 = Fabricate(:order, completed_at: 3.days.ago, merchant: merchant, amount: 100)
    order3 = Fabricate(:order, completed_at: 2.days.ago, merchant: merchant, amount: 1000)
    disbursement = Fabricate(:disbursement, merchant: merchant)

    expected_amount = (order1.amount + order2.amount + order3.amount) - (order1.fee + order2.fee + order3.fee)

    assert disbursement.amount.present?
    assert_equal disbursement.amount, expected_amount
    assert_equal disbursement.amount, disbursement.total_amount - disbursement.fee
  end
end
