class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  validates :amount,
            presence: true,
            numericality: true,
            comparison: { greater_than_or_equal_to: 0 }

  scope :complete, lambda {
    where.not(completed_at: nil)
  }

  scope :within_last_week,
        ->(date){ where("completed_at > ? AND completed_at <= ?", "#{ date - 1.week }%", "#{ date }")}

  # The disbursed amount has the following fee per order:
  # 1% fee for amounts smaller than 50 €
  # 0.95% for amounts between 50€ - 300€
  # 0.85% for amounts over 300€
  def fee
    if amount < 50
      amount * 0.01
    elsif amount < 300
      amount * 0.0095
    else
      amount * 0.0085
    end
  end

  def complete?
    completed_at.present?
  end

  def disbursed?
    Disbursement.find_by(merchant_id: merchant_id).present?
  end

end
