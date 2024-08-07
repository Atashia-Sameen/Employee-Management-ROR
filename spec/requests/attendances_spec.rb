require 'rails_helper'

RSpec.describe AttendancesController, type: :request do

  fixtures :users
  fixtures :organizations

  before do
    @attendance_today = @user.attendances.create!(date: Date.current, status: :present)
    @attendance_yesterday = @user.attendances.create!(date: Date.yesterday, status: :present)
  end

  describe '#index' do
    context "when user is a manager" do
      before do
        sign_in @manager
        get employee_attendances_path(@manager)
      end

      it 'sets all the Attendance records to @attendances' do
        expect(assigns(:attendances)).to eq(Attendance.all.ordered)
      end
    end

    context "when user is an employee or hr" do
      before do
        sign_in @user
        get employee_attendances_path(@user)
      end

      it 'sets the attendance of the current user to @attendances' do
        expect(assigns(:attendances)).to eq(@user.attendances.ordered)
      end
  
      it 'sets @attendance_today' do
        expect(assigns(:attendance_today)).to eq(@attendance_today)
      end
    end
  end

  describe 'GET /new' do
    context "when user is an employee or hr" do
      before do
        sign_in @user
        get new_employee_attendance_path(@user)
      end

      it 'assigns a new attendance to @attendance' do
        expect(assigns(:attendance)).to be_a_new(Attendance)
      end
    end
  end

  describe 'POST /create' do
    context "when user is an employee or hr" do
      before do
        sign_in @user
      end
  
      let(:new_attendance) { { attendance: { date: Date.tomorrow, status: 'present' } } }
  
      it 'creates a new attendance' do
        expect {
          post employee_attendances_path(@user), params: new_attendance
        }.to change(Attendance, :count).by(1)
      end
  
      it 'displays validation errors if attendance is invalid' do
        invalid_attendance = { attendance: { date: nil, status: 'absent' } }
  
        post employee_attendances_path(@user), params: invalid_attendance
        expect(response.body).to include("Date can't be blank")
      end
    end
  end
  
end
