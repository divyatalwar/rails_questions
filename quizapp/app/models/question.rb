class Question < ActiveRecord::Base
  
  validates :description, :question_type, presence: true
  validates :description, uniqueness: true
  validate :answer

  has_many :tests
  has_many :quizzes, through: :tests
  has_many :choices
  accepts_nested_attributes_for :choices

  scope :by_type, ->(type) { where('question_type = (?)', type) }
  
  def answer
    if choices.present? && choices.select { |choice| choice.correct }.length < 1
      errors.add :base, "Please select an answer.You cant leave it empty"
    end
  end

  def correct_choice
    choices.select { |choice| choice.correct == true }
  end

end
