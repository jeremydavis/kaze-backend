json.currencies do
  json.array!(@currencies) do |currency|
    json.extract! currency, :id, :shortname, :longname
  end
end
