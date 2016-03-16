class PostCommentsController < ApplicationController
before_action :set_post, :only => [:show, :create, :edit, :update, :destroy]

    def show
     
    end

	def new
    @comment = @post.build_comment
 	end

 	def create
 		
 	@comment = @post.comments.build(comment_params)

      @comment.save
    	flash[:notice] = "新增成功！！"
        redirect_to post_path(@post)
      

 	end

 	def edit
    

 	end

 	def update
	    if @comment.update(comment_params)
    	  flash[:notice] = "更新成功！！"
          redirect_to posts_path
      	else
          render :action => :edit
    	end
 	end

 	def destroy
      flash[:alert] = "刪除成功！"
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      
      redirect_to post_path(@post)		
 	end

private
def set_post

    @post = Post.find(params[:post_id])

end

def comment_params
  	params.require(:comment).permit(:content, :user_id, :post_id ,:status)
end

end
