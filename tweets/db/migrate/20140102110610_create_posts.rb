class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, index: true
      t.boolean :retweet, :default => false
      t.integer :shared_from
      t.timestamps
    end
  end
end
