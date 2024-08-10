class WorkFromHomeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wfh, only: [:show, :update]

  def index
    @work_from_homes = policy_scope(WorkFromHome)
    
    if current_user.manager?
      @work_from_homes = @work_from_homes.by_status(params[:status]) if params[:status].present?
      @work_from_homes = @work_from_homes.by_date_order(sort_order(params[:date])) if params[:date].present?
      @work_from_homes = @work_from_homes.by_name_order(sort_order(params[:name])) if params[:name].present?
    end
  end

  def show
  end

  def new
    @work_from_home = current_user.work_from_homes.new
    authorize @work_from_home
  end

  def create
    if wfh_limit_count?(params[:work_from_home][:date])
      respond_to do |format|
        format.html { redirect_to employee_work_from_homes_path, alert: 'Cannot apply for more WFH as you already have 2 in the previous two months.' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('flash_message_container', partial: 'shared/flash_message', 
          locals: { message: 'Cannot apply for more WFH as you already have 2 in the previous two months.' })
        end
      end
      return
    end
  
    @work_from_home = current_user.work_from_homes.new(wfh_params)
    authorize @work_from_home
  
    respond_to do |format|
      if @work_from_home.save
        format.html { redirect_to employee_work_from_homes_path, notice: 'Work From Home request applied successfully!' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('flash_message_container', partial: 'shared/flash_message', 
          locals: { message: 'Work From Home applied successfully!' })
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

  def wfh_limit_count?(new_wfh_date)
    new_wfh_date = Date.parse(new_wfh_date)
    start_date = new_wfh_date - 2.months
    current_user.work_from_homes.where('date >= ? AND date <= ?', start_date, new_wfh_date).count >= 2
  end
end
