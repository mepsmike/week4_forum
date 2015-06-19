class TopicsController < ApplicationController

	before_action :set_topic, :only =>[:show]

	def index
		@topics=Topic.all
		@categories=Category.all
	end

	def new
		@topic=Topic.new
	end

	def show
		set_topic
		@comment=Comment.new
		@comments=@topic.comments
	end

	def create
		@topic=Topic.new(get_params)
		@topic.save
		redirect_to topics_path
	end

	def get_params
		params.require(:topic).permit(:title, :content, :category_ids => [])
	end

	def set_topic

		@topic=Topic.find(params[:id])

	end

end
