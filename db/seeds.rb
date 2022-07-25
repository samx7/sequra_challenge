# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
if Merchant.count == 0
    path = File.join(File.dirname(__FILE__), "./seeds/merchants.json")
    file = JSON.parse(File.read(path))
    pp file["RECORDS"]
    file["RECORDS"].each{|r| Merchant.create!(r)}
    puts "Merchants created successfully!"
end

if Shopper.count == 0
    path = File.join(File.dirname(__FILE__), "./seeds/shoppers.json")
    file = JSON.parse(File.read(path))
    file["RECORDS"].each{|r| Shopper.create!(r)}
    puts "Shoppers created successfully!"
end

if Order.count == 0
    path = File.join(File.dirname(__FILE__), "./seeds/orders.json")
    file = JSON.parse(File.read(path))
    file["RECORDS"].each{|r| Order.create!(r)}
    puts "Orders created successfully!"
end
