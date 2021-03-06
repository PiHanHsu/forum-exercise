class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  :omniauthable, :omniauth_providers => [:facebook]

  has_many :posts
  has_many :comments

  has_many :likes
  has_many :like_posts, :through => :likes, :source => :posts

  has_many :subscriptions
  has_many :subscription_posts, :through => :subscriptions, :source => :posts

  #has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
                    :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
     # Case 1: Find existing user by facebook uid
     user = User.find_by_fb_uid( auth.uid )
     if user
        user.fb_token = auth.credentials.token
        #user.fb_raw_data = auth
        user.save!
       return user
     end

     # Case 2: Find existing user by email
     existing_user = User.find_by_email( auth.info.email )
     if existing_user
       existing_user.fb_uid = auth.uid
       existing_user.fb_token = auth.credentials.token
       #existing_user.fb_raw_data = auth
       existing_user.save!
       return existing_user
     end

     # Case 3: Create new password
     user = User.new
     user.fb_uid = auth.uid
     user.fb_token = auth.credentials.token
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     #user.fb_raw_data = auth
     user.save!
     return user
  end

  def admin?
	self.role == "admin"
  end
end
