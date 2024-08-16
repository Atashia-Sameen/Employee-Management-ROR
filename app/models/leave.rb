class Leave < ApplicationRecord
  include Filterable

  # Override inheritance_column to avoid STI issues with the 'type' column
  self.inheritance_column = nil

  belongs_to :user

  enum type: { casual: 0, sick: 1 }
  enum status: { not_approved: 0, approved: 1 }

  validates :date, presence: true, uniqueness: { scope: :user_id, message: 'You have already applied leave for this date.' } 

  scope :filter_by_type, -> (type) { where(type: type) }
  scope :filter_by_status, -> (status) { where(status: status) }
  scope :filter_by_date, -> (order) { order(date: order) }
  scope :filter_by_name, -> (order) { joins(:user).order("users.name #{order}") }

end
