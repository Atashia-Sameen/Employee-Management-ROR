class WorkFromHome < ApplicationRecord
  belongs_to :user

  enum status: { not_approved: 0, approved: 1 }

  scope :ordered, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_date_order, ->(order) { order(date: order) if order.present? }
  scope :by_name_order, ->(order) {
    joins(:user).order("users.name #{order}") if order.present?
  }

  validates :date, presence: true, uniqueness: { message: 'You have already applied WFH for this date.' }
end
