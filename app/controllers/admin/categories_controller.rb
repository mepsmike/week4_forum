class Admin::CategoriesController < ApplicationController

	before_action :authenticate_user!
  before_action :check_admin


  def check_admin
      unless current_user.admin?
          raise ActiveRecord::RecordNotFound
      end
  end

  def index
    
    @categories = Category.all
     
    if params[:cid]

      @category= Category.find(params[:cid])
    else 
      @category=Category.new
    end
      
  end

  def create

    @category=Category.new(get_params)
    @category.save
    redirect_to admin_categories_path

  end

  def update
    @category=Category.find(params[:id])
    @category.update(get_params)
    redirect_to admin_categories_path


  end

  def destroy

    @category=Category.find(params[:id])

    Category.destroy(@category)

    redirect_to admin_categories_path
  end





  def get_params

    params.require(:category).permit(:name)

  end

end
