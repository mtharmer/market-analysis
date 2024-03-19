json.extract! instrument, :id, :symbol, :exchange, :asset_class, :created_at, :updated_at
json.url instrument_url(instrument, format: :json)
