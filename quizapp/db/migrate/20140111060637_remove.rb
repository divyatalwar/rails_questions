class Remove < ActiveRecord::Migration
  def change
    remove_column :questions, :unique_code, :string
    add_column :quizzes, :unique_code, :string
  end
end
