require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  fixtures :users
  fixtures :organizations

  describe '#index' do
    context "when user is an hr or employee" do
      before do
        sign_in @user
        get employee_organization_index_path(@user)
      end

      it 'assigns all Organization records to @organizations' do
        expect(assigns(:organizations)).to include(@organization)
      end
    end
  end

  describe '#show' do
  end

  describe 'GET /new' do
    before do
      sign_in @user
      get new_employee_organization_path
    end

    it 'assigns a new organization to @organization' do
      expect(assigns(:organization)).to be_a_new(Organization)
    end
  end

  describe 'POST /create' do
    let(:valid_organization) { { organization: { name: 'New' } } }
    let(:invalid_organizationanization) { { organization: { name: '' } } }

    context "with valid parameters" do
      before do
        sign_in @user
      end

      it 'creates a new organization' do
        expect {
          post employee_organizations_path(@user), params: valid_organization
        }.to change(Organization, :count).by(1)
      end
    end

    context "with invalid params" do
      before do
        sign_in @user
      end

      it 'does not create a new organization' do
        expect {
          post employee_organizations_path(@user), params: invalid_organizationanization
        }.to change(Organization, :count).by(0)
      end
    end
  end

end
