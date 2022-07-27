class Disbursement < ApplicationRecord
  belongs_to :merchant
  has_many :orders, through: :merchant

  validates :date, presence: true

  before_create :set_amount

  scope :by_week,
        ->(week){ where("date > ? AND date <= ?", "#{week.beginning_of_week }", "#{ week.end_of_week}")}

  def viable_orders
    # @todo - send date as a parameter to have better control
    orders.complete.within_last_week(date.to_datetime)
  end

  def total_amount
    viable_orders.map(&:amount).inject(0, :+)
  end

  def fee
    viable_orders.map(&:fee).inject(0, :+)
  end

  private

  def set_amount
    self.amount = total_amount - fee
  end
end
