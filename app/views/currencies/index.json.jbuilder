json.array!(@currencies) do |currency|
  json.extract! currency, :id, :shortname, :longname
  json.url currency_url(currency, format: :json)
end
