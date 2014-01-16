class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers
  validates :content,  presence: true
  scope :for_quiz, ->(quiz_id) { where('quiz_id = ?', quiz_id)}
end
