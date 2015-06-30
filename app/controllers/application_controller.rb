class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end
  
	def sort_and_page #排序和分頁

		if params[:order]
			sort_by = case params[:order] 
				when 'num'
					'comments_count DESC '
				when 'latesttime'
					'last_commented_at DESC'
				when 'view'
					"view_counter DESC"
			end

			@topics = @topics.order(sort_by)
		else
			@topics = @topics.order("topics.id desc")
		end

		@topics = @topics.page(params[:page]).per(10)

	end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :intro
    devise_parameter_sanitizer.for(:account_update) << :intro
  end
  
end
