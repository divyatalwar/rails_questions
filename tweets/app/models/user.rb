class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :followings
  has_many :followees, through: :followings
  has_many :reverse_follows, class_name: "Following", foreign_key: 'followee_id'
  has_many :followers, through: :reverse_follows, source: :user
  has_many :posts, -> { order("updated_at desc") }



  validates :email, :lastname, :firstname, presence: true
  validates :email, uniqueness: true


  def to_param
    "#{firstname}".parameterize
  end

  def name
    firstname + " " + lastname
  end

end
