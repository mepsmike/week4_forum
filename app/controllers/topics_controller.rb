class TopicsController < ApplicationController

	before_action :set_topic, :only =>[:show,:destroy,:edit,:update]
	before_action :topic_list, :only =>[:index,:user_info,:collect_list]
	before_action :authenticate_user!, :except => [:index]

	def index
		
		@categories=Category.all
		
		if params[:cid] 
			@topics=@topics.joins(:categories).where(:categories => { :id => params[:cid] },:status => :t )
			
		else
			@topics=@topics.where(:status => :t)
			
		end

		sort_and_page
	end

	def new
		@topic=Topic.new
	end

	def show
		set_topic
		@topic.view_counter += 1
		@topic.save
		@comment=Comment.new
		@comments=@topic.comments
	end

	def create
		@topic=Topic.new(get_params)
		@topic.user = current_user
		@topic.save
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

		Topic.destroy(@topic)
		redirect_to topics_path

  end

  def collect
  	
  		@favorite=Favorite.create(:user_id => current_user.id,:topic_id => params[:tid])
  	
  		redirect_to topics_path
  	
  end

  def collect_list

  	@user = User.find(params[:uid])
  	@topics =@user.favorite_topics.page(params[:page]).per(10)
  	

  end

	def about

		@countuser = User.count

		@counttopic = Topic.count

		@countcomment= Comment.count

	end

	def user_info
		if params[:uid].to_i == current_user.id.to_i
			
			if params[:status] == "f"
				@topics=@topics.where(:user_id => params[:uid],:status => :f).page(params[:page]).per(10)
			else
				@topics=@topics.where(:user_id => params[:uid],:status => :t).page(params[:page]).per(10)

			end

		else 
			@introduce = User.find(params[:uid])
			@topics=@topics.where(:user_id => params[:uid]).page(params[:page]).per(10)


		end

		sort_and_page

	end

	def get_params
		params.require(:topic).permit(:title, :content, :status,:category_ids => [])
	end

	def set_topic

		@topic=Topic.find(params[:id])

	end

	def topic_list

		@topics=Topic.select("topics.id, topics.title,topics.view_counter as view, topics.user_id, count(comments.id) as num,max(comments.updated_at) as latesttime").joins("LEFT JOIN comments ON comments.topic_id = topics.id" ).group("topics.id")

	end

	def sort_and_page #排序和分頁

		case params[:order] 

		when 'num'
			sort_by = 'num DESC '

		when 'latesttime'
			sort_by = 'latesttime DESC'

		when 'view'
			sort_by = "view DESC"

		end
		#sort_by = (params[:order] == 'num') ? 'num DESC' : 'latesttime DESC'


		if params[:order]

			@topics=@topics.order(sort_by)

		end

		@topics=@topics.order("topics.id desc").page(params[:page]).per(10)

	end

end
