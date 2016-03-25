class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :set_post, :only => [:show, :edit, :update, :destroy]

	def index
    @categories = Category.all

    if params[:keyword]
      # Post.select_by_keyword(paramsp[:keyword])
      @posts = Post.where( [ "title like ?", "%#{params[:keyword]}%" ] )
    else
      @posts = Post.all
    end

    if params[:order]
      # Post.order_byx()
      sort_by = (params[:order] == 'title') ? 'title' : 'id'
      @posts = @posts.order(sort_by)
    end
		  
    if params[:category]
      @category = Category.find(params[:category])
      @posts = @category.posts
    end
    
      @posts = @posts.page(params[:page]).per(5).order(id: :asc)
      
	end

  def show
    @comments = @post.comments
    @comment = Comment.new
    
    if @post.views
      @post.views = @post.views + 1
    else
      @post.views = 1
    end
    
    @post.save
    
  end

	def new
    @post = Post.new
 	end

 	def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
    flash[:notice] = "新增成功！！"
    last_page = Post.all.count / 5
    if Post.all.count % 5 != 0
      last_page += 1
    end
    redirect_to posts_path(:page => last_page)
      else
        render :action => :new
      end 

 	end

 	def edit
    

 	end

 	def update
    if @post.update(post_params)
      flash[:notice] = "更新成功！！"

      redirect_to posts_path
      else
        render :action => :edit
    end
 	end

 	def destroy
      flash[:alert] = "刪除成功！"
      @post.destroy
      display_page = params[:page].to_i
      if Post.page(params[:page]).per(5).count == 0 && display_page > 1
        display_page  -= 1
      end
      redirect_to posts_path(:page => display_page) 		
 	end

  def dashboard
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
    
  end

  def profile
    @posts = current_user.posts.page(params[:page]).per(5).order(id: :asc)
  end

private
def set_post

    @post = Post.find(params[:id])

  end

  def post_params
  	params.require(:post).permit(:title, :content, :user_id, :status, :category_ids => [] )
  end



end


