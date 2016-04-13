class ApiV1::PostsController < ApiController

	def index
   	   render :json => { :message => "Test"}
   	end
 
   	def create
    	@post = Post.new( :title => params[:title],
                          :content => params[:content] )
 
     	if @post.save
       		render :json => { :id => @post.id }
     	else
       		render :json => { :message => "failed", :errors => @post.errors }, :status => 400
     	end
    end
end
