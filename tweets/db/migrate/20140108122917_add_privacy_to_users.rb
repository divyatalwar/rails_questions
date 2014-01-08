class AddPrivacyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_privacy, :boolean, :default => false
  end
end
