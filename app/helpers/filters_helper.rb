module FiltersHelper
  def type_filter
    [
      ['All', ''],
      ['Sick', 'sick'],
      ['Casual', 'casual']
    ]
  end

  def status_filter
    [
      ['All', ''],
      ['Approved', 'approved'],
      ['Not Approved', 'not_approved']
    ]
  end

  def date_filter
    [
      ['Date Ascending', 'asc'],
      ['Date Descending', 'desc']
    ]
  end

  def name_filter
    [
      ['Name Ascending', 'asc'],
      ['Name Descending', 'desc']
    ]
  end
end
