class CreateUserAnswersTable < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.references :user
      t.references :choice
      t.references :quiz
      t.references :question
    end
  end
end
