class Category < ActiveRecord::Base
    has_many :post_categoryships
    has_many :post, through: :post_categoryships

end
