class Shopper < ApplicationRecord
  has_many :orders

  validates :name, presence: true
  validates :email,
            uniqueness: true,
            format: { with: URI:: MailTo::EMAIL_REGEXP}

  validates :nif,
            uniqueness: true

  before_create :set_nif

  private

  def set_nif
    self.nif ||= "41#{SecureRandom.hex}"
  end
end
