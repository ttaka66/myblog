json.array!(@comments5) do |comment|
	json.extract! comment, :member_id, :comment, :cmttitle, :created_at
	json.id @article.id
end