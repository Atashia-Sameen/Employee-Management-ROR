module AttendanceHelper
  def attendance_table_headers
    if current_user.manager?
      ['Name', 'Role', 'Day', 'Date', 'Status']
    else
      ['Day', 'Date', 'Status']
    end
  end

  def attendance_table_rows
    @attendances.map do |attendance|
      if current_user.manager?
        [
          { content: attendance.user.name },
          { content: attendance.user.role.humanize },
          { content: attendance.date.strftime('%A') },
          { content: attendance.date.strftime('%d/%m/%Y') },
          { content: attendance.status, class: attendance.present? ? 'text-green-600' : 'text-red-600' }
        ]
      else
        [
          { content: attendance.date.strftime('%A') },
          { content: attendance.date.strftime('%d/%m/%Y') },
          { content: attendance.status, class: attendance.present? ? 'text-green-600' : 'text-red-600' }
        ]
      end
    end
  end
end
