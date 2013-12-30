class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start
      t.date :end
      t.boolean :publishing_bit, :default => false
      t.boolean  :published
      t.timestamps
    end
  end
end
