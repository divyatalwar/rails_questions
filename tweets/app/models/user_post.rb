class UserPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :shared_From, :class_name => 'User', :foreign_key => 'shared_from'
  belongs_to :post

  scope :by_users, ->(users) { where('user_id in (?)', users).order('created_at DESC') }



  def creator?(user)
    user_id == user.id
  end

  def tweet
   retweet
  end

  def clone_post(user)
    UserPost.create(post_id: post_id, user_id: user.id, retweet: true, shared_from: user_id)
  end

end