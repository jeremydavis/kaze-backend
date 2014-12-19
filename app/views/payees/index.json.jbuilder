json.array!(@payees) do |payee|
  json.extract! payee, :id, :nickname, :account_holder, :account_number, :bank_name, :branch_name
  json.url payee_url(payee, format: :json)
end
