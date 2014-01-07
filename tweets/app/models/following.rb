class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, class_name: 'User'
  validates :user_id, :followee_id, presence:true
  validates :user_id, uniqueness: { scope: [:followee_id] }
  #FIXME_AB: Can I follow myself?
  #FIXME_AB: What happens when a user tries to follow the user who he is already following?
end
