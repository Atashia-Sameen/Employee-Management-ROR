module ApplicationHelper
  def sidebar_links
    case current_user.role
    when 'manager'
      [
        { name: 'Attendance Records', path: employee_attendances_path },
        { name: 'Leaves Report', path: employee_leaves_path },
        { name: 'WFH Report', path: employee_work_from_homes_path }
      ]
    when 'hr'
      [
        { name: 'Attendance Records', path: employee_attendances_path },
        { name: 'Leaves Report', path: employee_leaves_path },
        { name: 'WFH Report', path: employee_work_from_homes_path },
        { name: 'Create Organization', path: employee_organizations_path }
      ]
    when 'employee'
      [
        { name: 'Mark Attendance', path: employee_attendances_path },
        { name: 'Mark Leave', path: employee_leaves_path },
        { name: 'Work From Home', path: employee_work_from_homes_path }
      ]
    else
      []
    end
  end
end
