class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :followings
  has_many :followees, through: :followings
  has_many :reverse_follows, class_name: "Following", foreign_key: 'followee_id'
  has_many :followers, through: :reverse_follows, source: :user
  has_many :tweets
  has_many :posts, through: :tweets
  validates :email, :lastname, :firstname, presence: true
  validates_format_of :email, :with => EMAIL_FORMAT
  validates_uniqueness_of :email, :lastname, :firstname, :case_sensitive => false


  def to_param
    "#{firstname}".parameterize
  end

  def name
    firstname + " " + lastname
  end


  def timeline
    @users = followees + [self]
    Tweet.by_users(@users)
  end

end
