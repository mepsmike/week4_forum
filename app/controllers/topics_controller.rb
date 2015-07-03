class TopicsController < ApplicationController

	before_action :set_topic, :only =>[:show, :collect]
	before_action :set_my_topic, :only => [:destroy,:edit,:update]
	before_action :authenticate_user!, :except => [:index]

	def index
		@topics = Topic.all
		@categories=Category.all	

		if params[:cid] 
			@topics=@topics.joins(:categories).where(:categories => { :id => params[:cid] }, :status => :t )		
		else
			@topics=@topics.where(:status => :t)	
		end
		sort_and_page
	end

	def new

		gon.tags = Tag.all.map{ |x| x.name } #要放在最前面？！
		@topic=Topic.new
		
	end



	def show
		set_topic
		
		@favorite = get_favorite

		@topic.increment!(:view_counter)

		@comment=Comment.new
		@comments=@topic.comments
	end

	def create
		@topic=Topic.new(get_params)
		@topic.user = current_user
		@topic.save # TODO: handle failed case

		redirect_to topics_path
	end

	def edit
		render :action => :new
	end

	def update
		@topic.update(get_params)

		redirect_to topics_path
	end

	def destroy
		@topic.destroy

  	redirect_to topics_path
  end

  def collect
  	@f = get_favorite

  	if @f
  		@f.destroy
  	else
  		current_user.favorites.create!( :topic => @topic )
  	end

  	respond_to do |format|
     format.html {
       redirect_to topic_path(@topic)
     }
     format.js
    end

  	
  end


  def about

  	@countuser = User.count
  	@counttopic=Topic.count
  	@countcomment=Comment.count

  end

	protected

	def get_params
		params.require(:topic).permit(:title, :content, :status, :logo, :tag_list, :category_ids => [])
	end

	def set_topic
		@topic=Topic.find(params[:id])
	end

	def set_my_topic
		@topic = current_user.topics.find(params[:id])
	end

	def get_favorite
		current_user.favorites.find_by_topic_id( params[:tid] || params[:id] )
	end

end
