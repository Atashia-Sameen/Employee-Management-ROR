module ApplicationHelper
  def sidebar_links
    base_sidebar_links = [
      { name: 'Attendance Records', path: employee_attendances_path },
      { name: 'Leaves Records', path: employee_leaves_path },
      { name: 'WFH Records', path: employee_work_from_homes_path }
    ]

    base_sidebar_links << { name: 'Manage Organization', path: employee_organizations_path } if current_user.hr?

    base_sidebar_links

  end
end
