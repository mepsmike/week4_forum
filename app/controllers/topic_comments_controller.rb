class TopicCommentsController < ApplicationController

	before_action :authenticate_user!
 	before_action :get_topic
	
	def create
		@comment=@topic.comments.build(get_params)
		@comment.user=current_user
		@comment.save

		@topic.touch(:last_commented_at)

		respond_to do |format|
     format.html {
       redirect_to topic_path(@topic)
     }
     format.js
    end

		#redirect_to topic_path(@topic)
	end

	def destroy
		get_my_comment
		@comment.destroy
		
		
		respond_to do |format|
     format.html {
       redirect_to topic_path(@topic)
     }
     format.js
    end

	end

	protected
	
	def get_params
		params.require(:comment).permit(:content,:user_id)
	end

	def get_topic
		@topic=Topic.find(params[:topic_id])
	end

	def get_my_comment
		@comment=current_user.comments.find(params[:id])
	end
end
