class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_hr!
  before_action :set_organization, only: [:show, :edit, :update]

  def index
    @organizations = Organization.all
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.creator_id = current_user.id
    if @organization.save
      redirect_to employee_organizations_path, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  # def update
  #   if @organization.update(organization_params)
  #     redirect_to @organization, notice: 'Organization was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  private

  def authorize_hr!
    unless current_user.hr?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name)
  end
end
