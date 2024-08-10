require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  fixtures :all

  let(:hr) { users(:hr) }
  let(:manager) { users(:manager) }
  let(:organization) { organizations(:techieminions) }

  before do
    sign_in hr
  end

  describe '#index' do
    context "when user is an hr" do
      before do
        get employee_organizations_path(hr)
      end

      it 'assigns all Organization records to organizations' do
        expect(assigns(:organizations)).to include(organization)
      end
    end
  end

  describe '#new' do
    before do
      get new_employee_organization_path
    end

    it 'assigns a new organization to organization' do
      expect(assigns(:organization)).to be_a_new(Organization)
    end
  end

  describe '#create' do
    let(:valid_organization) { { organization: { name: 'New' } } }
    let(:invalid_organization) { { organization: { name: '' } } }

    before do
      sign_in user
      ActionController::Base.allow_forgery_protection = false
    end

    context "with valid parameters" do
      it 'creates a new organization' do
        expect {
          post employee_organizations_path(hr), params: valid_organization
        }.to change(Organization, :count).by(1)
      end
    end

    context "with invalid params" do
      it 'does not create a new organization' do
        expect {
          post employee_organizations_path(hr), params: invalid_organization
        }.to change(Organization, :count).by(0)
      end
    end
  end

end
