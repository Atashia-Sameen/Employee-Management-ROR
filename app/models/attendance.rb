class Attendance < ApplicationRecord
  belongs_to :user

  enum status: { absent: 0, present: 1 }

  scope :ordered, -> { order(created_at: :desc) }

  validates :date, presence: true
end
