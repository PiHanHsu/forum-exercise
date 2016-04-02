class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @catogories = Category.all
  end

  def new 
  	@category = Category.new
  end

  def create
  	@category = Category.new(category_params)
  	@category.save
    flash[:alert] = "新增成功！"
    redirect_to admin_posts_path
  end

  def show
    #no need
  end

  def edit
  	#no need
  end

  def update
  	flash[:alert] = "更新成功！"
  	@category.update(category_params)
  	

  end

  def destroy
  	@category = Category.find(params[:id])
    if @category.posts.count == 0
    	@category.destroy
  	    flash[:alert] = "刪除成功！"
  	else
  		flash[:alert] = "無法刪除"
  	end

  	redirect_to admin_posts_path

  end

private

  def category_params
  	params.require(:category).permit(:name)
  end

end
