json.array!(@widgets) do |widget|
  json.extract! widget, :id, :name, :description, :picture, :price
  json.url widget_url(widget, format: :json)
end
