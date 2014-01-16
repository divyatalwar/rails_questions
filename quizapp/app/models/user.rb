class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:google_oauth2]
  
  validates :email, :username, presence: true
  validates :email, format: { with: EMAIL_FORMAT }
  validates :email, :username, uniqueness: true, :case_sensitive => false

  has_many :user_answers

  has_many :choices, through: :user_answers
  has_many :results
  has_many :quizzes, through: :results
  scope :except, ->(id) { where.not(id: id)} 

  def admin?
    user_type == "admin"
  end


  def calculate_score(quiz_id)
    correct = incorrect = 0
    choices.for_quiz(quiz_id).each do |choice|
      correct += 1 if choice.correct
    end
    Result.create(:user_id => id, :quiz_id => quiz_id, :score => correct)
  end

  
end
