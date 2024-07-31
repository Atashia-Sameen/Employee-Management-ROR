class MarkAttendanceJob < ApplicationJob
  def perform
    puts 'job perform'
  end
end