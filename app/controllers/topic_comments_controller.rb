class TopicCommentsController < ApplicationController

 	before_action :get_topic
	
	def create
		@comment=@topic.comments.build(get_params)
		@comment.save
		redirect_to topics_path
	end

	def get_params
		params.require(:comment).permit(:content)
	end

	def get_topic
		@topic=Topic.find(params[:topic_id])
	end
end
