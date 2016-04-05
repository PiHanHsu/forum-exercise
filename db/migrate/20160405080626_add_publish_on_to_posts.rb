class AddPublishOnToPosts < ActiveRecord::Migration
  def change
  	 add_column :posts, :publish_on, :date
  	 change_column :posts, :status, :string, default: "draft"
  end
end
