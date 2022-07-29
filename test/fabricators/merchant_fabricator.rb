# frozen_string_literal: true

Fabricator(:merchant) do
  name  { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  email { Faker::Internet.email.to_s }
  cif   { "B6#{SecureRandom.hex}" }
end
