class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :question
      t.boolean :correct, :default => false
      t.timestamps
    end
  end
end
