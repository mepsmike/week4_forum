module TopicsHelper

	def merge_topics_params(new_params)
		{ :order => params[:order], :cid => params[:cid] }.merge( new_params )
	end

end
