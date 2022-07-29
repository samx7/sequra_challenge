# frozen_string_literal: true

class Disbursement < ApplicationRecord
  belongs_to :merchant
  has_many :orders, through: :merchant

  validates :date, presence: true

  before_create :set_amount

  scope :by_week,
        -> (week) { where('date > ? AND date <= ?', week.beginning_of_week.to_s, week.end_of_week.to_s) }

  def viable_orders
    # @todo - send date as a parameter to have better control
    orders.complete.within_last_week(date.to_datetime)
  end

  def total_amount
    viable_orders.sum(&:amount)
  end

  def fee
    viable_orders.sum(&:fee)
  end

  private

  def set_amount
    self.amount = total_amount - fee
  end
end
