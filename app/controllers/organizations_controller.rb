class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    authorize @organizations
  end

  def new
    @organization = Organization.new
    authorize @organization
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.creator_id = current_user.id

    authorize @organization

    if @organization.save
      redirect_to employee_organizations_path, notice: 'Organization was successfully created.'
    else
      flash.now[:alert] = @organization.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
