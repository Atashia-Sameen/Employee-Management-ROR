class WorkFromHomeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wfh, only: [:show, :update]

  def index
    @work_from_homes = policy_scope(WorkFromHome).ordered
    @work_from_homes = @work_from_homes.by_date_order(sort_order(params[:date]))
    @work_from_homes = @work_from_homes.by_name_order(sort_order(params[:name]))
  end

  def show
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
          render turbo_stream: turbo_stream.replace('work_from_home_form', partial: 'work_from_home/work_from_home_success')
        end
      else
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('work_from_home_form', partial: 'work_from_home/form',
          locals: { work_from_home: @work_from_home })
        end
      end
    end
  end

  def update
    authorize @work_from_home
    if @work_from_home.update(status: 'approved')
      redirect_to employee_work_from_homes_path, notice: 'Work From Home request approved successfully!'
    else
      redirect_to employee_work_from_homes_path, alert: 'Failed to approve Work From Home request.'
    end
  end

  private

  def set_wfh
    if current_user.manager?
      @work_from_home = WorkFromHome.find(params[:id])
    else
      @work_from_home = current_user.work_from_homes.find(params[:id])
    end
    authorize @work_from_home
  end

  def wfh_params
    params.require(:work_from_home).permit(:date, :status)
  end

  def sort_order(order)
    order == 'ascending' ? :asc : :desc
  end

end
