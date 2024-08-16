Organization.create([
  { name: 'TechieMinions', creator_id: 1 },
  { name: 'Kickstart', creator_id: 2 }
])

User.create([
  { name: 'hr', email: 'hr@gmail.com', password: 'password', role: :hr },
  { name: 'employee', email: 'employee@gmail.com', password: 'password', role: :employee },
  { name: 'manager', email: 'manager@gmail.com', password: 'password', role: :manager }
])

Attendance.create([
  { user_id: 1, date: Date.current - 1, status: :present },
  { user_id: 2, date: Date.current, status: :absent }
])

WorkFromHome.create([
  { user_id: 1, date: Date.current - 1, status: :approved },
  { user_id: 2, date: Date.current, status: :not_approved }
])

Leave.create([
  { user_id: 1, date: Date.current - 1, status: :approved, type: :sick },
  { user_id: 2, date: Date.current, status: :not_approved, type: :casual }
])

