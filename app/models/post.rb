class Post < ActiveRecord::Base
   has_many :post_categoryships
   has_many :categories, through: :post_categoryships 
   has_many :comments
   
   belongs_to :user 
     
   has_many :likes
   has_many :like_users, :through => :likes, :source => :user

   has_many :subscriptions
   has_many :subscription_users, :through => :subscriptions, :source => :user

   def find_like_by(user)
   	 self.likes.find_by_user_id( user.id )
   end

   def find_subscription_by(user)
   	 self.subscriptions.find_by_user_id( user.id )
   end

end
