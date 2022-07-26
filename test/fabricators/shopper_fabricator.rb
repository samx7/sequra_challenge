Fabricator(:shopper) do
  name  { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  email { "#{Faker::Internet.email}" }
  nif   { "41#{SecureRandom.hex}" }
end
