require "test_helper"

class DisbursementWorkerTest < ActionDispatch::IntegrationTest

  def setup
    create_merchants_with_orders(3, 3)
  end

  test "perform should work as expected" do
    DisbursementWorker.new.perform
    assert_equal 3, Disbursement.all.count
  end

  private

  def create_merchants_with_orders(num_merchants, num_orders)
    num_merchants.times do
      merchant = Fabricate(:merchant)
      num_orders.times do
        Fabricate(:order, merchant: merchant, completed_at: 2.days.ago)
      end
    end
  end

end
