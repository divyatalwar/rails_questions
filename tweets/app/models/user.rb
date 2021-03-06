class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :followings, dependent: :destroy
  has_many :followees, through: :followings
  has_many :reverse_follows, class_name: "Following", foreign_key: 'followee_id'
  has_many :followers, through: :reverse_follows, source: :user
  has_many :tweets, dependent: :destroy
  has_many :posts, through: :tweets
  validates :email, :lastname, :firstname, :username, presence: true
  #FIXME_AB: why using old formats? validates_format_of and validates_uniqueness_of
  ##fixed
  
  validates :email, format: { with: EMAIL_FORMAT }
  #FIXME_AB: Two users cannot have same first name or last name. Why? How would you handle this?
  #fixed
  validates :email, :username, uniqueness: true, :case_sensitive => false
  validates :firstname, uniqueness: { scope: [:lastname] }

  scope :except, ->(user) { where.not(id: user) }

  def to_param
    "#{username}".parameterize
  end

  def timeline
    #FIXME_AB: Why instance variable
    #needed to access the instance since timline includes yourslef along with your followees
    @users = followees + [self]
    Tweet.by_users(@users).eager_loading_associations
  end

  def update_privacy
    update_attributes({:profile_privacy => !profile_privacy})
  end

  def self.get_autocomplete_suggestions
    User.pluck('username')
  end

end
