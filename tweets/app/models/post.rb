class Post < ActiveRecord::Base
  include UserConcern
  has_many :tweets
  has_many :users, through: :tweets
  validates :content, presence: true, :length => { :maximum => 10 }

  after_commit :save_associated_tweets

  def save_associated_tweets
    tweets.create({ user_id: current_user.id })
  end


end
