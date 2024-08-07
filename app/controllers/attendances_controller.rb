class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance, only: [:show]
  before_action :authorize_attendance, only: [:index, :new, :create]

  def index
    @attendances = policy_scope(Attendance.all).ordered
    @attendance_today = current_user.attendances.find_by(date: Date.current) unless current_user.manager?
  end

  def show
  end

  def new
    @attendance = current_user.attendances.new(date: Date.current)
  end

  def create
    @attendance = current_user.attendances.new(attendance_params)

    if @attendance.save
      redirect_to employee_attendances_path(current_user, @attendance), notice: 'Attendance marked successfully.'
    else
      render :new, alert: 'Failed to mark attendance.'
    end
  end

  private

  def set_attendance
    @attendance = if current_user.manager?
                    Attendance.find(params[:id])
                  else
                    current_user.attendances.find(params[:id])
                  end
    authorize @attendance
  end

  def attendance_params
    params.require(:attendance).permit(:date, :status)
  end

  def authorize_attendance
    authorize Attendance
  end

end
