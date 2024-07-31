class LeavesController < ApplicationController
  before_action :set_leave, only: [:update]

  def index
    if current_user.manager?
      @leaves = Leave.all
      @leaves = @leaves.by_type(params[:type])
      @leaves = @leaves.by_status(params[:status])
      @leaves = @leaves.by_date_order(sort_order(params[:date]))
      @leaves = @leaves.by_name_order(sort_order(params[:name]))
      @leaves = @leaves.ordered
    else
      @leaves = current_user.leaves.ordered
    end
  end
  
  def show
    @leaves = current_user.leaves
  end

  def new
    @leave = current_user.leaves.new
  end
  
  def create
    @leave = current_user.leaves.new(leave_params)

    respond_to do |format|
      if @leave.save
        format.html { redirect_to employee_leaves_path, notice: 'Leave applied successfully!' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('leave_form', partial: 'leaves/leave_success')
        end
      else
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('leave_form', partial: 'leaves/form', locals: { leave: @leave })
        end
      end
    end
  end

  def update
    @leave = Leave.find(params[:id])
    if @leave.update(status: 'approved')
      redirect_to employee_leaves_path, notice: 'Leave approved successfully!'
    else
      redirect_to employee_leaves_path, alert: 'Failed to approve leave.'
    end
  end

  private

  def set_leave
    @work_from_home = WorkFromHome.find(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:date, :type, :status)
  end

  def sort_order(order)
    order == 'ascending' ? :asc : :desc
  end

end
