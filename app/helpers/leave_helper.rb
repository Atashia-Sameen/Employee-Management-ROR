module LeaveHelper
  def leave_table_headers
    if current_user.manager?
      ['Name', 'Role', 'Day', 'Date', 'Type', 'Status', 'Update']
    else
      ['Day', 'Date', 'Type', 'Status']
    end
  end

  def leave_table_rows
    @leaves.map do |leave| 
      if current_user.manager?
        [
          
          { content: leave.user.name },
          { content: leave.user.role.humanize },
          { content: leave.date.strftime('%A') },
          { content: leave.date.strftime('%d/%m/%Y') },
          { content: leave.type.humanize },
          { content: leave.status.humanize, class: leave.not_approved? ? 'text-red-600' : 'text-green-600' },
          { content: leave.not_approved? ? 
                        button_to('Approve', employee_leave_path(leave.user.id, leave.id), method: :patch, 
                        class: 'custom-btn', 
                        form: { data: { turbo_confirm: 'Are you sure you want to approve this leave?' } }) :
                        link_to('Approved', '#', class: 'px-3 py-2 text-sm text-white rounded-2xl bg-neutral-700 cursor-default', disabled: true)
          }
        ]
      else
        [
          { content: leave.date.strftime('%A') },
          { content: leave.date.strftime('%d/%m/%Y') },
          { content: leave.type.humanize },
          { content: leave.status.humanize, class: leave.not_approved? ? 'text-red-600' : 'text-green-600' },
        ]
      end
    end
  end
end
