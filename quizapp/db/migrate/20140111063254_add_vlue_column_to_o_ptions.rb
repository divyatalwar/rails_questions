class AddVlueColumnToOPtions < ActiveRecord::Migration
  def change
    add_column :choices, :content, :string
  end
end
