class Quiz < ActiveRecord::Base

  validate :questions_presence
  validates :unique_code, presence: true
  validates :unique_code, uniqueness: true
 
  has_many :tests
  has_many :user_answers
  has_many :choices, through: :user_answers
  has_many :questions, through: :tests
  has_many :results
  has_many :users, through: :results
 
  accepts_nested_attributes_for :tests, update_only: true
  default_scope { order('quizzes.updated_at asc') }
  
  before_validation :generate_unique_code

  def questions_presence
    if tests.size < 1 
      errors.add(:base, "A quiz must have at least one question.")
    end
  end
 
  def generate_unique_code
    update_attribute(:unique_code, SecureRandom.hex(3))
  end

  def calculate_score(user)
    correct = 0
     correct = choices.for_user(user.id).select { |choice| choice.correct }.count
    result = Result.create(:user_id => user.id, :quiz_id => id, :score => correct)
    result 
  end

  def to_param
    "#{unique_code}".parameterize
  end

  def attempted?(user)
    users.include?(user)
  end
 
end
