class Admin::UsersController < ApplicationController

	before_action :authenticate_user!
  before_action :check_admin


  def check_admin
      unless current_user.admin?
          raise ActiveRecord::RecordNotFound
      end
  end

	def index

		@users = User.all

		if params[:uid]

			@user=User.find(params[:uid])

		else
			@user= User.new
		end
	
	end

	def create

		@user=User.new(get_params)
		@user.save
		redirect_to admin_users_path


	end


	def update

		@user=User.find(params[:id])
		@user.update(get_params)
		redirect_to admin_users_path

	end


	def get_params

		params.require(:user).permit(:intro,:role)
	end




end
