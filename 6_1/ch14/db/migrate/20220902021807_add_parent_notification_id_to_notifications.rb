class AddParentNotificationIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :parent_notification_id, :integer
  end
end
