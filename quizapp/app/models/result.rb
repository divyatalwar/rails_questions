class Result < ActiveRecord::Base
  validates :user_id, :quiz_id, :score, presence: true
  validates_uniqueness_of :quiz_id, scope: :user_id
  belongs_to :quiz, touch: true
  belongs_to :user
  scope :by_user, ->(user_id) { where('user_id = ? ', user_id)}

  def incorrect
    quiz.questions.size - score
  end

end

