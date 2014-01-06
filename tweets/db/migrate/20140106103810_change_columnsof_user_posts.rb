class ChangeColumnsofUserPosts < ActiveRecord::Migration
  def change
    rename_table :user_posts, :tweets
    rename_column :tweets, :retweet, :retweeted
    rename_column :tweets, :shared_from, :retweeted_from
  end
end
