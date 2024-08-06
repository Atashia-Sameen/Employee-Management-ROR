class LeavesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_leave, only: [:show, :update]

  def index
    @leaves = policy_scope(Leave)
  
    if current_user.manager?
      @leaves = @leaves.by_type(params[:type]) if params[:type].present?
      @leaves = @leaves.by_status(params[:status]) if params[:status].present?
      @leaves = @leaves.by_date_order(sort_order(params[:date])) if params[:date].present?
      @leaves = @leaves.by_name_order(sort_order(params[:name])) if params[:name].present?
    end
    # debugger
  end
  

  def show
  end

  def new
    @leave = current_user.leaves.new
    authorize @leave
  end

  def create
    @leave = current_user.leaves.new(leave_params)
    authorize @leave

    respond_to do |format|
      if @leave.save
        format.html { redirect_to employee_leaves_path, notice: 'Leave applied successfully!' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('leave_form', partial: 'shared/flash_message', locals: { message: 'Leave applied successfully!' })
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
    if @leave.update(status: 'approved')
      redirect_to employee_leaves_path, notice: 'Leave approved successfully!'
    else
      redirect_to employee_leaves_path, alert: 'Failed to approve leave.'
    end
  end

  private

  def set_leave
    if current_user.manager?
      @leave = Leave.find(params[:id])
    else
      @leave = current_user.leaves.find(params[:id])
    end
    authorize @leave
  end

  def leave_params
    params.require(:leave).permit(:date, :type, :status)
  end

  def sort_order(order)
    order == 'ascending' ? :asc : :desc
  end  

end
