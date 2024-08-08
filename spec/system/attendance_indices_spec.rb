require 'rails_helper'

RSpec.describe "AttendanceIndices", type: :system do
  fixtures :users

  before do
    @manager = users(:manager)
    @user = users(:employee)
    @attendance_today = @user.attendances.create!(date: Date.current, status: :present)
  end

  before do
    driven_by(:rack_test)
  end

  context 'when the user is a manager' do
    before do
      sign_in @manager
      visit employee_attendances_path
    end

    it 'shows attendance of all users in a table ' do
      expect(page).to have_content('Attendance Record')

      within 'table' do
        within 'thead' do
          expect(page).to have_css('.font-bold', text: 'Name')
          expect(page).to have_css('.font-bold', text: 'Role')
          expect(page).to have_css('.font-bold', text: 'Day')
          expect(page).to have_css('.font-bold', text: 'Date')
          expect(page).to have_css('.font-bold', text: 'Status')
        end
        expect(page).to have_content(@manager.name)
        expect(page).to have_content(@manager.role.humanize)
        expect(page).to have_content(attendance_today.date.strftime('%A'))
        expect(page).to have_content(attendance_today.date.strftime('%d/%m/%Y'))
        expect(page).to have_css('.text-green-600', text: attendance_today.status)
      end
    end
  end

  context 'when the user is not a manager' do
    before do
      sign_in @user
      visit employee_attendances_path
    end

    it 'shows attendance of all users in a table ' do
      expect(page).to have_content('Attendance Record')
      expect(page).to have_link('Mark Attendance', href: new_employee_attendance_path(user))
      
      within 'table' do
        within 'thead' do
          expect(page).to have_css('.font-bold', text: 'Day')
          expect(page).to have_css('.font-bold', text: 'Date')
          expect(page).to have_css('.font-bold', text: 'Status')
        end
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.role.humanize)
        expect(page).to have_content(attendance_today.date.strftime('%A'))
        expect(page).to have_content(attendance_today.date.strftime('%d/%m/%Y'))
        expect(page).to have_css('.text-green-600', text: attendance_today.status)
      end
    end
  end
  
end
