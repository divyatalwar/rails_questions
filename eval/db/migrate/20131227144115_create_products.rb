class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :quantity
      t.boolean :publishing_bit, :default => false
      t.references :offer
      t.boolean  :published
      t.timestamps
    end
  end
end
