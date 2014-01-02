class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, class_name: 'User'
  validates :user_id, :followee_id, presence:true
end
