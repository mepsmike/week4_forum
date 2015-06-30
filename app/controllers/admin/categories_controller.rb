class Admin::CategoriesController < ApplicationController

	before_action :authenticate_user!
  before_action :check_admin

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
    @category.destroy
    
    redirect_to admin_categories_path
  end

  protected

  def get_params
    params.require(:category).permit(:name)
  end

end
