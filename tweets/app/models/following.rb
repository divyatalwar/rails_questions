class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, class_name: 'User'
  validates :user_id, :followee_id, presence:true
  validates :user_id, uniqueness: { scope: [:followee_id] }
  validate :prevent_self_retweet
  #FIXME_AB: Can I follow myself?
  #fixed
  
  #FIXME_AB: What happens when a user tries to follow the user who he is already following?
  #sir i have already added a uniqueness constraint in the scope of followee id

  
  def prevent_self_retweet
    errors.add(:base, "You cannot follow your self") if user_id == followee_id
  end
  
end
