class FriendshipsController < ApplicationController
	def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id],:status => :invite)
    if @friendship.save
      flash[:notice] = "已送出好友邀請"
      
      #respond_to do |format|
       #format.html {
        # redirect_to topic_path(@topic)
       #}
       #format.js
      #end
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end


  def update
    
    @friendship = current_user.friendships.find(params[:fid])
    @friendship.update(:status => :accept)
  end

end
