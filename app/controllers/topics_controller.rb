class TopicsController < ApplicationController

	before_action :set_topic, :only =>[:show]
	before_action :authenticate_user!, :except => [:index]

	def index
		
		@categories=Category.all
		
		if params[:cid] 
			@topics=Topic.select("topics.id, topics.title, count(comments.id) as num,max(comments.updated_at) as latesttime").joins("LEFT JOIN comments ON comments.topic_id = topics.id" ).group("topics.id").joins(:categories).where(:categories => { :id => params[:cid] } )
		else
			#@topics=Topic.all

			@topics=Topic.select("topics.id, topics.title, count(comments.id) as num,max(comments.updated_at) as latesttime").joins("LEFT JOIN comments ON comments.topic_id = topics.id" ).group("topics.id")
			
		end
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
