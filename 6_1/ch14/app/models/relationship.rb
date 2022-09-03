class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_one :notifications, as: :subject, dependent: :destroy
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create_commit :create_notifications

  def create_notifications
    now = Time.zone.now
    target_time = now - 300
    parent_notification = Notification.where(user: followed).where(action_type: "followed_me").where("created_at > ?", target_time).where(parent_notification_id: nil).take

    if parent_notification.present?
      Notification.create(subject: self, user: followed, action_type: :followed_me, parent_notification_id: parent_notification.id)
    else
      Notification.create(subject: self, user: followed, action_type: :followed_me)
    end
  end
end
