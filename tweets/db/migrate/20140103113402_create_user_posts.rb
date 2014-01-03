class CreateUserPosts < ActiveRecord::Migration
  def change
    create_table :user_posts do |t|
      t.references :user
      t.references :post
      t.boolean :retweet, :default => false
      t.integer :shared_from
      t.timestamps

    end
  end
end
