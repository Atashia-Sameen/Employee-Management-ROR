class WorkFromHomeController < ApplicationController
  include Filterable

  before_action :set_wfh, only: [:update]

  def index
    @work_from_homes = policy_scope(WorkFromHome)
    @work_from_homes = WorkFromHome.filter(filtering_params)  if current_user.manager?
    authorize @work_from_homes
  end

  def new
    @work_from_home = current_user.work_from_homes.new
    authorize @work_from_home
  end

  def create
    @work_from_home = current_user.work_from_homes.new(wfh_params)
    authorize @work_from_home
  
    respond_to do |format|
      if @work_from_home.save
        format.html { redirect_to employee_work_from_homes_path, notice: 'Work From Home request applied successfully!' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('wfh_form', partial: 'shared/success_message', 
          locals: { message: 'Work From Home applied successfully!', redirect_path: employee_work_from_homes_path(current_user) })
        end
      else
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('wfh_form', partial: 'work_from_home/form', 
          locals: { messages: @work_from_home.errors.full_messages })
        end
      end
    end
  end

  def update
    authorize @work_from_home

    debugger

    if @work_from_home.update(status: 'approved')
      redirect_to employee_work_from_homes_path, notice: 'Work From Home request approved successfully!'
    else
      redirect_to employee_work_from_homes_path, alert: @work_from_home.errors.full_messages.join(", ")
    end
  end

  private

  def set_wfh
    @work_from_home =  WorkFromHome.find(params[:id])
  end

  def wfh_params
    params.require(:work_from_home).permit(:date)
  end

  def filtering_params
    params.slice(:status, :date, :name)
  end

end
