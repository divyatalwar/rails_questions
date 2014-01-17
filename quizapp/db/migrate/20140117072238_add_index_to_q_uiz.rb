class AddIndexToQUiz < ActiveRecord::Migration
  def change
    add_index :tests, :question_id
    add_index :user_answers, :choice_id
    add_index :user_answers, :quiz_id
    add_index :user_answers, :question_id
  end
end
