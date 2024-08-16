class LeavesController < ApplicationController
  include Filterable

  before_action :set_leave, only: [:update]

  def index
    @leaves = policy_scope(Leave)
    @leaves = Leave.filter(filtering_params) if current_user.manager?
    authorize @leaves
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
          render turbo_stream: turbo_stream.replace('leave_form', partial: 'shared/success_message',
          locals: { message: 'Leave applied successfully!', redirect_path: employee_leaves_path(current_user) })
        end
      else
        format.html do
          flash[:alert] = @leaves.errors.full_messages
          render :new
        end
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('leave_form', partial: 'shared/flash_message', 
          locals: { message: @leave.errors.full_messages })
        end
      end
    end
  end

  def update
    authorize @leave

    if @leave.update( status: :approved )
      redirect_to employee_leaves_path, notice: 'Leave approved successfully!'
    else
      redirect_to employee_leaves_path, alert: @leave.errors.full_messages.join(", ")
    end
  end

  private

  def set_leave
    @leave =  if current_user.manager?
                Leave.find(params[:id])
              else
                current_user.leaves.find(params[:id])
              end

    authorize @leave
  end

  def leave_params
    params.require(:leave).permit(:date, :type)
  end

  def filtering_params
    params.slice(:type, :status, :date, :name)
  end

end
