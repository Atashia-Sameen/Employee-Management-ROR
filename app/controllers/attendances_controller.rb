class AttendancesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_attendance, only: [:show, :destroy]

  def index
    if current_user.manager?
      @attendances = Attendance.all.ordered
    else
      @attendances = current_user.attendances.ordered
      @attendance_today = current_user.attendances.find_by(date: Date.today)
    end
  end

  def show
    if current_user.manager?
      @attendance = Attendance.find(params[:id])
    else
      @attendance = current_user.attendances.find(params[:id])
    end
  end

  def new
    @attendance = current_user.attendances.new(date: Date.today)
  end

  def create
    @attendance = current_user.attendances.new(attendance_params)
    if @attendance.save
      redirect_to employee_attendances_path(current_user), notice: 'Attendance marked successfully.'
    else
      render :new, alert: 'Failed to mark attendance.'
    end
  end

  private

  # def set_attendance
  #   if current_user.manager?
  #     @attendance = Attendance.find(params[:id])
  #   else
  #     @attendance = current_user.attendances.find(params[:id])
  #   end
  # end

  def attendance_params
    params.require(:attendance).permit(:date, :status)
  end
end
