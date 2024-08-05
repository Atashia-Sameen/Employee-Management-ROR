class Leave < ApplicationRecord
  # Override inheritance_column to avoid STI issues with the 'type' column
  self.inheritance_column = nil

  belongs_to :user

  enum type: { casual: 0, sick: 1 }
  enum status: { not_approved: 0, approved: 1 }

  validates :date, presence: true, uniqueness: {message: 'You have already applied leave for this date.'}

  scope :by_type, -> (type) { where(type: type)}
  scope :by_status, -> (status) { where(status: status)}
  scope :by_date_order, -> (order) { order(date: order)}
  scope :by_name_order, -> (order) {
    joins(:user).order("users.name #{order}")
  }
  scope :ordered, -> { order(created_at: :desc) }
end
