class TopicCommentsController < ApplicationController

	before_action :authenticate_user!
 	before_action :get_topic
	
	def create
		@comment=@topic.comments.build(get_params)
		@comment.user=current_user
		@comment.save

		@topic.touch(:last_commented_at)

		redirect_to topics_path
	end

	protected
	
	def get_params
		params.require(:comment).permit(:content,:user_id)
	end

	def get_topic
		@topic=Topic.find(params[:topic_id])
	end
end
