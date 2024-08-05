class MarkAttendanceJob < ApplicationJob
  queue_as :default

  def perform
    puts 'job performed'
    User.find_each do |user|
      if user.attendances.where(date: Date.today).empty?
        user.attendances.create(date: Date.today, status: 'absent')
      end
    end
  end
end
