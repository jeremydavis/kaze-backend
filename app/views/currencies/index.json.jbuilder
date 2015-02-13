json.currencies do
  json.array!(@currencies) do |currency|
    json.extract! currency, :id, :shortname, :longname
  end
end
json.meta do
  json.extract! @currencies, :current_page, :num_pages, :total_pages
  json.prev_page = @currencies.prev_page unless @currencies.first_page?
  json.next_page = @currencies.next_page unless @currencies.last_page?
end