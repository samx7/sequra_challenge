# frozen_string_literal: true

Fabricator(:shopper) do
  name  { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  email { Faker::Internet.email.to_s }
  nif   { "41#{SecureRandom.hex}" }
end
