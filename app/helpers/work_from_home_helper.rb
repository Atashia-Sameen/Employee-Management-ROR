module WorkFromHomeHelper
  def wfh_table_headers
    if current_user.manager?
      ['Name', 'Role', 'Day', 'Date', 'Status', 'Update']
    else
      ['Day', 'Date', 'Status']
    end
  end

  def wfh_table_rows
    @work_from_homes.map do |wfh| 
      if current_user.manager?
        [
          { content: wfh.user.name },
          { content: wfh.user.role.humanize },
          { content: wfh.date.strftime('%A') },
          { content: wfh.date.strftime('%d/%m/%Y') },
          { content: wfh.status.humanize, class: wfh.not_approved? ? 'text-red-600' : 'text-green-600' },
          { content: wfh.not_approved? ? 
            button_to('Approve', employee_work_from_home_path(wfh.user.id, wfh.id), method: :patch, 
                      class: 'custom-btn', 
                      form: { data: { turbo_confirm: 'Approve WFH request?' } }) : 
            link_to('Approved', '#', class: 'custom-disabled-btn', disabled: true)
          }
        ]
      else  
        [
          { content: wfh.date.strftime('%A') },
          { content: wfh.date.strftime('%d/%m/%Y') },
          { content: wfh.status.humanize, class: wfh.not_approved? ? 'text-red-600' : 'text-green-600' },
        ]
      end
    end
  end
end
