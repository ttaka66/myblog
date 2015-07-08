json.array!(@comments) do |comment|
  json.extract! comment, :id, :member_id, :article_id, :comment
  json.url comment_url(comment, format: :json)
end
