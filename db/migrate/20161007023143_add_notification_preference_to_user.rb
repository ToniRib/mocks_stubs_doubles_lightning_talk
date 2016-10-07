class AddNotificationPreferenceToUser < ActiveRecord::Migration
  def change
    add_column :users, :notification_preference, :string
  end
end
