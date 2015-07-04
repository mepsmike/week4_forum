module TopicsHelper

	def merge_topics_params(new_params)
		{ :order => params[:order], :cid => params[:cid] }.merge( new_params )
	end

	def admin?
		current_user.role=="admin"
	end

	def current_user?
		@topic.user_id == current_user.id
	end

	

end
