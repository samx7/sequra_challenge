class Merchant < ApplicationRecord
  has_many :orders,
           :dependent => :destroy
  has_many :disbursements

  validates :name, presence: true
  validates :email,
            uniqueness: true,
            format: { with: URI:: MailTo::EMAIL_REGEXP}

  validates :cif,
            uniqueness: true

  before_create :set_cif

  private

  def set_cif
    self.cif ||= "B6#{SecureRandom.hex}"
  end
end
