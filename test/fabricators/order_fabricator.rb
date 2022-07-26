Fabricator(:order) do
  merchant
  shopper
  amount { rand(10000) / 10.0 }
  completed_at { Time.current }
end
