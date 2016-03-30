class LikesController < ApplicationController
	before_action :authenticate_user!
    before_action :set_post

	def create
	  like = @post.find_like_by(current_user)
	  if like
	  	#do nothing
	  else
	  	@post.likes.create!( :user => current_user)
	  end

	  redirect_to :back
	end

	def destroy
   	  @like = current_user.likes.find( params[:id])
   	  @like.destroy

   	  redirect_to :back
	end

	protected

	 def set_post
       @post = Post.find( params[:post_id] )
     end
end
