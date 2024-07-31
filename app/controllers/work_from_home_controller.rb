class WorkFromHomeController < ApplicationController
  before_action :set_wfh, only: [:update]

  def index
    if current_user.manager?
      @work_from_homes = WorkFromHome.all
      @work_from_homes = @work_from_homes.by_status(params[:status])
      @work_from_homes = @work_from_homes.by_date_order(sort_order(params[:date]))
      @work_from_homes = @work_from_homes.by_name_order(sort_order(params[:name]))
      @work_from_homes = @work_from_homes.ordered
    else
      @work_from_homes = current_user.work_from_homes.ordered
    end
    # @work_from_homes = current_user.manager? ? WorkFromHome.all.ordered : current_user.work_from_homes.ordered
  end
  
  def show
    @work_from_homes = current_user.work_from_homes
  end

  def new
    @work_from_home = current_user.work_from_homes.new
  end

  def create
    @work_from_home = current_user.work_from_homes.new(wfh_params)
  
    respond_to do |format|
      if @work_from_home.save
        format.html { redirect_to employee_work_from_homes_path, notice: 'WFH applied successfully!' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('wfh_form', partial: 'work_from_home/success')
        end
      else
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('wfh_form', partial: 'work_from_home/form', locals: { work_from_home: @work_from_home })
        end
      end
    end
  end
  

  def update
    if @work_from_home.update(status: 'approved')
      redirect_to employee_work_from_homes_path
    else
      redirect_to employee_work_from_homes_path, alert: 'Failed to approve WorkFromHome.'
    end
  end

  private
  
  def set_wfh
    @work_from_home = WorkFromHome.find(params[:id])
  end

  def wfh_params
    params.require(:work_from_home).permit(:date, :status)
  end

  def sort_order(order)
    order == 'ascending' ? :asc : :desc
  end

end
