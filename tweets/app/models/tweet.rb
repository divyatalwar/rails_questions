class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :retweeted_from_user, :class_name => 'User', :foreign_key => 'retweeted_from'
  belongs_to :post
  scope :by_users, ->(users) { where(user_id: users).order(created_at: :desc) }
  scope :by_hash_tag, ->(hash_tag) { includes(:post).where( 'posts.content like ?', '%' + hash_tag + '%').references(:post)}
  scope :by_user_tag, ->(user) { includes(:post).where('posts.tags  like (?)', "% " + user.id.to_s + " %").references(:post)}
  default_scope { order(created_at: :desc) } 


  def creator?(user)
    user_id == user.id
  end

  def retweet(user)
    @user = User.find_by(id: user_id)
    if @user.present? && @user.profile_privacy
      errors.add(:base, "You cannot retweet the post.it is a private profile")
      return false
    end 
    Tweet.create(post_id: post_id, user_id: user.id, retweeted: true, retweeted_from: user_id)
  end

  def self.eager_loading_associations
    includes( :user, :post, :retweeted_from_user)
  end


end