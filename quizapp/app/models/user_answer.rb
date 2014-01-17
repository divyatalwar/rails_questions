class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :choice
  belongs_to :quiz
  belongs_to :question
  validates  :quiz_id , :choice_id, :question_id, presence: true
  validates :question_id, uniqueness: {scope: [:quiz_id, :user_id], :message => " answer has already been recorded.Cannot change it" }
end