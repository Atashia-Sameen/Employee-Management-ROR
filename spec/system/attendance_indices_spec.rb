require 'rails_helper'

RSpec.describe "AttendanceIndices", type: :system do
  fixtures :all
  let(:user) { users(:employee) }
  let(:manager) { users(:manager) }
  let(:all_attendance) { attendances }
  let(:user_attendance) { user.attendances }

  before do
    driven_by(:rack_test)
  end

  context 'when the user is a manager' do
    before do
      sign_in manager
      visit employee_attendances_path(manager)
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

        within 'tbody' do
          all_attendance.each do |attendance|
            expect(page).to have_content(attendance.user.name)
            expect(page).to have_content(attendance.user.role.humanize)
            expect(page).to have_content(attendance.date.strftime('%A'))
            expect(page).to have_content(attendance.date.strftime('%d/%m/%Y'))
            expect(page).to have_css(attendance.present? ? '.text-green-600' : '.text-red-600', text: attendance.status)
          end
        end
      end
    end
  end

  context 'when the user is not a manager' do
    before do
      sign_in user
      Attendance.where(user: user, date: Date.current).destroy_all
      visit employee_attendances_path(user)
    end

    it 'shows attendances of the current user in a table ' do
      expect(page).to have_content('Attendance Record')
      
      within 'table' do
        within 'thead' do
          expect(page).to have_css('.font-bold', text: 'Day')
          expect(page).to have_css('.font-bold', text: 'Date')
          expect(page).to have_css('.font-bold', text: 'Status')
        end

        within 'tbody' do
          user_attendance.each do |attendance|
            expect(page).to have_content(attendance.date.strftime('%A'))
            expect(page).to have_content(attendance.date.strftime('%d/%m/%Y'))
            expect(page).to have_css(attendance.present? ? '.text-green-600' : '.text-red-600', text: attendance.status)
          end
        end
      end
    end

    context 'mark attendance button' do
      before do
        @attendance_today = Attendance.create(user: user, date: Date.current, status: :present)
        sign_in user
        visit employee_attendances_path(user)
      end
    
      it 'displays a link to mark new attendance when the button is enabled' do
        @attendance_today.destroy
    
        visit employee_attendances_path(user)
    
        expect(page).to have_link('Mark Attendance', href: new_employee_attendance_path(user))
        click_link 'Mark Attendance', href: new_employee_attendance_path(user)
        expect(page).to have_current_path(new_employee_attendance_path(user))
      end
    
      it 'does not allow access to new attendance page when the button is disabled' do
        visit employee_attendances_path(user)
    
        expect(page).to have_button('Mark Attendance', disabled: true)

        expect(page).not_to have_current_path(new_employee_attendance_path(user))
        expect(page).to have_current_path(employee_attendances_path(user))
      end
    end    
    
  end
  
end
