json.products @products do |product|
  json.extract! product, :id, :name, :content, :category_id
  json.url product_url(product, format: :json)
end