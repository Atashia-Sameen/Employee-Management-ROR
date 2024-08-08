class WorkFromHome < ApplicationRecord
  belongs_to :user

  enum status: { not_approved: 0, approved: 1 }

  validates :date, presence: true, uniqueness: { message: 'You have already applied WFH for this date.' }

  scope :ordered, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status)}
  scope :by_date_order, ->(order) { order(date: order)}
  scope :by_name_order, ->(order) {
    joins(:user).order("users.name #{order}")
  }
end
