module PostsHelper

	def post_status_options
 
     Post::STATUS.map do |status|
       [ t(status, :scope => "post.status"), status ]
     end
    end
end
