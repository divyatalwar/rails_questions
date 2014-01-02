class Post < ActiveRecord::Base
  belongs_to :user
  validates :content, :user_id, presence: true,:length => { :maximum => 160 }

  scope :by_users, ->(users) { where('user_id in (?)', users).order('created_at DESC') }

  def clone_post(user)
    Post.create(content: content, user_id: user.id)
  end

  def creator?(user)
    user_id == user.id
  end

end
