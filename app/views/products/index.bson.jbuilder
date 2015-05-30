json.products @products do |product|
  json.extract! product, :id, :name, :content
  json.url product_url(product, format: :json)
end