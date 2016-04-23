class ApiV1::PostsController < ApiController

	def index
   	  render :json => { :message => "Test"}
  end

  def show
      render :json => { :message => "Show"}
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

  def update
    @post = Post.find( params[:id] )

    columns = [:title, :content]

    #if params.slice(*columns).keys.any?
    if columns.any?{ |c| params.key?(c) }
      columns.each do |column|
        @post[column] = params[column] if params[column]
      end

      if @post.save
        render :json => { :id => @post.id }
      else
        render :json => { :message => "failed", :errors => @topic.errors }, :status => 400
      end

    else
      render :json => { :message => "no keys"}, :status => 400
    end
  end

  def destroy
    @post = Post.find( params[:id] )
    @post.destroy

    render :json => { :message => "OK" }
  end
end
