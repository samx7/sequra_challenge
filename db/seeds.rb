# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
if Merchant.count.zero?
  path = File.join(File.dirname(__FILE__), './seeds/merchants.json')
  file = JSON.parse(File.read(path))
  Rails.logger.debug(file['RECORDS'])
  file['RECORDS'].each { |r| Merchant.create!(r) }
  Rails.logger.debug('Merchants created successfully!')
end

if Shopper.count.zero?
  path = File.join(File.dirname(__FILE__), './seeds/shoppers.json')
  file = JSON.parse(File.read(path))
  file['RECORDS'].each { |r| Shopper.create!(r) }
  Rails.logger.debug('Shoppers created successfully!')
end

if Order.count.zero?
  path = File.join(File.dirname(__FILE__), './seeds/orders.json')
  file = JSON.parse(File.read(path))
  file['RECORDS'].each { |r| Order.create!(r) }
  Rails.logger.debug('Orders created successfully!')
end
