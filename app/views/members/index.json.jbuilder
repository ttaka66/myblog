json.array!(@members) do |member|
  json.extract! member, :id, :name, :password, :birthday, :comefrom, :interest, :ctype, :photo, :comments_count
  json.url member_url(member, format: :json)
end
