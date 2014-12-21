json.array!(@transfers) do |transfer|
  json.extract! transfer, :id, :account_id, :payee_id, :currency_id, :value, :description, :transfer_date, :repeat, :repeat_until, :status, :submitted_at, :transaction_password_valid, :one_time_password_valid
  json.url transfer_url(transfer, format: :json)
end
