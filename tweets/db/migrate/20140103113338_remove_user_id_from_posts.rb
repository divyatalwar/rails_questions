class RemoveUserIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :user_id, :integer
    remove_column :posts, :shared_from, :integer
    remove_column :posts, :retweet, :boolean
  end
end
