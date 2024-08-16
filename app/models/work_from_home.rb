class WorkFromHome < ApplicationRecord
  include Filterable

  belongs_to :user

  enum status: { not_approved: 0, approved: 1 }

  validates :date, presence: true, uniqueness: { scope: :user_id, message: 'You have already applied WFH for this date.' }

  scope :filter_by_status, -> (status) { where(status: status) }
  scope :filter_by_date, -> (order) { order(date: order) }
  scope :filter_by_name, -> (order) { joins(:user).order("users.name #{order}") }

  before_create :limit_count

  def limit_count
    start_date = 2.months.ago(self.date)
    count = self.class.where(user: self.user)
              .where(status: :approved)
              .where('date >= ? AND date <= ?', start_date, self.date)
              .count

    return if count < 2

    errors.add(:base, "Cannot apply for more WFH as you already have 2 in the previous two months.")
    throw(:abort)
  end

end
