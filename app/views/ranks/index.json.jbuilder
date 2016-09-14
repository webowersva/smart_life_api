json.total_pages @top_sports.total_pages
json.current_page @top_sports.current_page

index = 0
json.top(@top_sports) do |sport|
	user_info = sport.user.user_info
	if user_info
	  index += 1
	  json.index index
	  json.avatar image_url user_info.try(:avatar).try(:url, :medium)
	  json.nickname user_info.nickname
	  json.count sport.count
  end
end