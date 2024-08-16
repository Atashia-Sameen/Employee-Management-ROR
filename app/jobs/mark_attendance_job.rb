class MarkAttendanceJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      next if user.attendances.where(date: Date.current).present?
      user.attendances.create(date: Date.current)
    end
  end
end
