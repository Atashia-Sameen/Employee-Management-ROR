class AttendancesController < ApplicationController
  before_action :set_attendance_today, only: [:index, :new]
  before_action :check_attendance_marked, only: [:new, :create]

  def index
    @attendances = policy_scope(Attendance)
    authorize @attendances
  end

  def new
    @attendance = current_user.attendances.new(date: Date.current)
    authorize @attendance
  end
  
  def create
    @attendance = current_user.attendances.new(attendance_params)
    @attendance.date = Date.current
    authorize @attendance

    if @attendance.saveq
      redirect_to employee_attendances_path(current_user), notice: 'Attendance marked successfully.'
    else
      flash.now[:alert] = @attendance.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:status)
  end

  def set_attendance_today
    @attendance_today = current_user.attendances.find_by(date: Date.current)
  end

  def check_attendance_marked
    if @attendance_today.present?
      redirect_to employee_attendances_path(current_user), alert: "You have already marked attendance for today."
    end
  end
end
