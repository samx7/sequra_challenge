# frozen_string_literal: true

require 'test_helper'

class ShopperTest < ActiveSupport::TestCase
  test 'Shopper does not allow null name' do
    shopper = Fabricate.build(:shopper, name: nil)
    assert_not shopper.valid?
  end

  test 'Shopper should have valid email' do
    shopper = Fabricate.build(:shopper, email: 'invalid')
    assert_not shopper.valid?
  end

  test 'Shopper with valid attributes should be valid' do
    shopper = Fabricate.build(:shopper)
    assert shopper.valid?
  end

  test 'CIF should be generated before saving' do
    shopper = Fabricate(:shopper, nif: nil)
    assert shopper.nif.present?
  end

  test 'Shopper emails should be unique' do
    email = Faker::Internet.email
    Fabricate(:shopper, email: email)
    shopper = Fabricate.build(:shopper, email: email)
    assert_not shopper.valid?
  end

  test 'Shopper NIF should be unique' do
    nif = SecureRandom.hex
    Fabricate(:shopper, nif: nif)
    shopper = Fabricate.build(:shopper, nif: nif)
    assert_not shopper.valid?
  end

  test 'Shopper orders should be deleted upon shopper deletion' do
    shopper = Fabricate(:shopper)
    Fabricate(:order, merchant: Fabricate(:merchant), shopper: shopper)
    shopper_id = shopper.id
    assert_not shopper.orders.empty?
    shopper.destroy!
    assert Order.where(shopper_id: shopper_id).empty?
  end
end
