class Result < ActiveRecord::Base
  validates :user, :quiz, :score, presence: true
  validates :score, numericality: { only_integer: true }
  validates :quiz_id, uniqueness: { scope: :user_id }
  belongs_to :quiz, touch: true
  belongs_to :user
  scope :by_user, ->(user_id) { where('user_id = ? ', user_id)}

  def incorrect
    quiz.questions.size - score
  end

end

