json.array!(@articles) do |article|
  json.extract! article, :id, :member_id, :title, :article
  json.url article_url(article, format: :json)
end
