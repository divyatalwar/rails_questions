class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.decimal :discount
        t.boolean :publishing_bit, :default => false
        t.references :event
        t.boolean  :published
      t.timestamps
    end
  end
end
