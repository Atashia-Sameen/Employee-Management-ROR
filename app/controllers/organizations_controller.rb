class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit]
  before_action :authorize_organization, only: [:index, :show, :new, :create, :edit]

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

  # def update
  #   if @organization.update(organization_params)
  #     redirect_to @organization, notice: 'Organization was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name)
  end

  def authorize_organization
    authorize Organization
  end
end
