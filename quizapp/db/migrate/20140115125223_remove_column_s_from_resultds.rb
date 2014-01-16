class RemoveColumnSFromResultds < ActiveRecord::Migration
  def change
    remove_column :results, :correct, :integer
    remove_column :results, :incorrect, :integer
  end
end
