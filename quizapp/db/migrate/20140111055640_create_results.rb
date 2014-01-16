class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :quiz
      t.references :user
      t.integer :score
      t.integer :correct
      t.integer :incorrect

      t.timestamps
    end
  end
end
