class UsersController < ApplicationController

	before_action :authenticate_user!

	def show
		@user = User.find( params[:id] )
		@topics = @user.topics.page(params[:page]).per(10)

		if @user == current_user
			if params[:status] == "f"
				@topics = @topics.where( :status => :f)
			else
				@topics = @topics.where( :status => :t)
			end
		else 
			@topics = @topics.where( :status => :t)
		end
		
		sort_and_page
	end

  def collect_list
  	@user = current_user
  	@topics =@user.favorite_topics.page(params[:page]).per(10)
  end

end
