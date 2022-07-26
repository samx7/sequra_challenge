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

end
