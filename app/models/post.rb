class Post < ActiveRecord::Base
   has_many :post_categoryships
   has_many :categories, through: :post_categoryships 
   has_many :comments
   
   belongs_to :user 

end
