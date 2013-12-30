class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
    	t.string :name
    	t.string :type
    	t.boolean :ethernet ,:default => false
    	t.boolean :wifi,:default => false
    	t.boolean :inkjet,:default => false
    	t.boolean :laser,:default => false
      t.timestamps
    end
  end
end
