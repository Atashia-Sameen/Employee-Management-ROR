require 'rails_helper'

RSpec.describe AttendancesController, type: :request do
  fixtures :all

  let(:user) { users(:employee) }
  let(:manager) { users(:manager) }
  let(:attendance_today) { attendances(:present) }

  describe '#index' do
    context "when user is a manager" do
      before do
        sign_in manager
        get employee_attendances_path(manager)
      end

      it 'sets all the Attendance records to @attendances' do
        expect(assigns(:attendances)).to eq(Attendance.all.ordered)
      end
    end

    context "when user is an employee or hr" do
      before do
        sign_in user
        get employee_attendances_path(user)
      end

      it 'sets the attendance of the current user to @attendances' do
        expect(assigns(:attendances)).to eq(user.attendances.ordered)
      end
  
      it 'sets @attendance_today' do
        expect(assigns(:attendance_today)).to eq(attendance_today)
      end
    end
  end

  describe '#new' do
    context "when user is an employee or hr" do
      before do
        sign_in user
        get new_employee_attendance_path(user)
      end

      it 'assigns a new attendance to attendance' do
        expect(assigns(:attendance)).to be_a_new(Attendance)
      end
    end
  end

  describe '#create' do
    context "when user is an employee or hr" do
      before do
        sign_in user
        ActionController::Base.allow_forgery_protection = false
      end

      it 'creates a new attendance if valid' do
        expect {
          post employee_attendances_path(user), params: { attendance: { date: Date.tomorrow, status: :present } }.to_json
        }.to change(user.attendances, :count).by(1)
      end
  
      it 'does not create attendance and displays errors if invalid' do
        invalid_attendance = { attendance: { date: nil } }
  
        expect {
          post employee_attendances_path(user), params: invalid_attendance
        }.to not_to(user.attendances, :count)

        expect(response.body).to include("Date can't be blank")
      end
    end
  end
  
end
