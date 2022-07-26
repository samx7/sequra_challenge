require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test "Merchant does not allow null name" do
    merchant = Fabricate.build(:merchant, name: nil)
    assert_not merchant.valid?
  end

  test "Merchant should have valid email" do
    merchant = Fabricate.build(:merchant, email: 'invalid')
    assert_not merchant.valid?
  end

  test "Merchant with valid attributes should be valid" do
    merchant = Fabricate.build(:merchant)
    assert merchant.valid?
  end

  test "CIF should be generated before saving" do
    merchant = Fabricate(:merchant, cif: nil)
    assert merchant.cif.present?
  end

  test "Merchant emails should be unique" do
    email = Faker::Internet.email
    Fabricate(:merchant, email: email)
    merchant = Fabricate.build(:merchant, email: email)
    assert_not merchant.valid?
  end

  test "Merchant CIF should be unique" do
    cif = SecureRandom.hex
    Fabricate(:merchant, cif: cif)
    merchant = Fabricate.build(:merchant, cif: cif)
    assert_not merchant.valid?
  end

  test "Merchant order should be deleted upon merchant deletion" do
    skip
  end
end
