class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers
  validates :content,  presence: true, :length => { :maximum => 50 }
  ##not able to implement this uniqueness constraint##
  # validates :content, uniqueness: { scope: [:question_id], :message => "Please enter a different choice" }
  # scope :for_quiz, ->(quiz_id) { where('quiz_id = ?', quiz_id)}
  scope :for_user, ->(user_id) { where('user_answers.user_id = (?)', user_id)}
end
