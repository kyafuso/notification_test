class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  enum action_type: { followed_me: 0, first_to_login: 1 }
end
