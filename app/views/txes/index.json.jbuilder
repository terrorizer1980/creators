json.array!(@txes) do |tx|
  json.extract! tx, :id, :user_id, :txtype, :currency, :direction, :amount_cents, :balance_cents, :notes
  json.url tx_url(tx, format: :json)
end
