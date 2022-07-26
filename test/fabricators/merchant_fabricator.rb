Fabricator(:merchant) do
  name  { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  email { "#{Faker::Internet.email}" }
  cif   { "B6#{SecureRandom.hex}" }
end
