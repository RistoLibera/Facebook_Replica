class Notification < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }
  scope :unseen, -> { where(status: :unseen) }

  enum status: [ :seen, :unseen ]
  
  belongs_to :user

  validates :user_id, :message, :url, :sender_id, presence: true
end