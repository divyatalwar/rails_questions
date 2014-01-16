class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :unique_code
      t.string :question_type

      t.timestamps
    end
  end
end
