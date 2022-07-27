require "test_helper"

class MerchantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @week = Time.now
    2.times do
      merchant = Fabricate(:merchant)
      3.times{ Fabricate(:order, merchant: merchant, completed_at: 2.days.ago)}
      3.times{ Fabricate(:order, merchant: merchant, completed_at: 10.days.ago)}
      Disbursement.create(date: Time.now, merchant_id: merchant.id)
      Disbursement.create(date: Time.now - 1.week, merchant_id: merchant.id)
    end

  end

  test "GET /merchant/disbursement - missing week" do
    get merchant_disbursements_url
    assert_equal response.status, 400
  end

  test "GET /merchant/disbursement - merchant not found" do
    get merchant_disbursements_url, params: {week: @week, id: 127}
    assert_equal response.status, 404
  end

  test "GET /merchant/disbursement - no id provided" do
    get merchant_disbursements_url, params: {week: @week}
    assert_equal response.status, 200
    assert_equal 4, Disbursement.all.count
    assert_equal 2, response.parsed_body.size #returns 2 existing disbursements for this week and all merchants
  end

  test "GET /merchant/disbursement - id provided" do
    id = Merchant.last.id
    get merchant_disbursements_url, params: {week: @week, id: id}
    assert_equal 4, Disbursement.all.count
    assert_equal response.status, 200
    assert_equal 1, response.parsed_body.size #returns 1 existing disbursements for this week and selected merchant
  end
end
