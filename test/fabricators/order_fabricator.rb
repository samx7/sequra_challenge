# frozen_string_literal: true

Fabricator(:order) do
  merchant
  shopper
  amount { rand(10_000) / 10.0 }
  completed_at { Time.current }
end
