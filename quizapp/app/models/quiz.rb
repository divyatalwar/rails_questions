class Quiz < ActiveRecord::Base

  validate :questions_presence
 
  has_many :tests
  has_many :user_answers
  has_many :choices, through: :user_answers
  has_many :questions, through: :tests
  has_many :results
  has_many :users, through: :results
 
  accepts_nested_attributes_for :tests, update_only: true, reject_if: proc { |attributes| attributes['_destroy'].blank? }
 
  default_scope { order('quizzes.updated_at asc') }
  after_commit :generate_unique_code

  def questions_presence
    if tests.size < 1 
      errors.add(:base, "A quiz must have at least one question.")
    end
  end
 
  def generate_unique_code
    update_column(:unique_code, SecureRandom.hex(3))
  end


  def to_param
    "#{unique_code}".parameterize
  end

  def has_already_been_taken?(user)
    users.include?(user)
  end
 
end
