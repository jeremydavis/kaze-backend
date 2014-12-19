json.array!(@accounts) do |account|
  json.extract! account, :id, :account_number, :currency_id, :balance
  json.url account_url(account, format: :json)
end
