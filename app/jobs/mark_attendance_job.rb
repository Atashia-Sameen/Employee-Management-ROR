class MarkAttendanceJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      if user.attendances.where(date: Date.current).empty?
        next if user.attendances.create(date: Date.current).present?
      end
    end
  end
end
