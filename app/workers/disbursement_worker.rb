class DisbursementWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
      Merchant.all.find_each do |merchant|
        date = Time.now.beginning_of_week
        Disbursement.create(merchant_id: merchant.id, date: date)
      end
  end
  # @todo - add programmed job to call this worker weekly on Mondays
end
