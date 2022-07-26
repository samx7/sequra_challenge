Fabricator(:disbursement) do
  merchant
  date        { Time.current }
  amount      100.5
end
