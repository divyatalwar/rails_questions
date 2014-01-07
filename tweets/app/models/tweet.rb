class Tweet < ActiveRecord::Base
  include UserConcern
  belongs_to :user
  belongs_to :retweeted_from_user, :class_name => 'User', :foreign_key => 'retweeted_from'
  belongs_to :post

  scope :by_users, ->(users) { where(user_id: users).order(created_at: :desc) }


  def creator?(user)
    user_id == user.id
  end

  def retweet
    Tweet.create(post_id: post_id, user_id: current_user.id, retweeted: true, retweeted_from: user_id)
  end

  def self.eager_loading_associations
    includes( :user, :post, :retweeted_from_user)
  end


end