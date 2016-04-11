json.array!(@subscribers) do |subscriber|
  json.extract! subscriber, :id, :longitude, :latitude
  json.url subscriber_url(subscriber, format: :json)
end
