require 'rails_helper'

RSpec.describe "WorkFromHomes", type: :request do
  fixtures :all

  let(:user) { users(:employee) }
  let(:manager) { users(:manager) }
  let(:work_from_home) {work_from_homes(:approved)}

  describe '#index' do
    context "when user is a manager" do
      before do
        sign_in manager
        get employee_work_from_homes_path(manager)
      end

      it 'sets all the WorkFromHome records to work_from_homes' do
        new_wfh = WorkFromHome.all.ordered.by_date_order(:asc).by_name_order(:asc)

        expect(assigns(:work_from_homes).pluck(:id)).to match_array(new_wfh.pluck(:id))
      end
    end

    context "when user is an employee or hr" do
      before do
        sign_in user
        get employee_work_from_homes_path(user)
      end

      it 'sets the WorkFromHome records of the current user to work_from_homes' do
        new_wfh = user.work_from_homes.ordered.by_date_order(:asc).by_name_order(:asc)
        expect(assigns(:work_from_homes).pluck(:id)).to match_array(new_wfh.pluck(:id))
      end
    end
  end

  describe '#new' do
    context "when user is an hr or employee" do
      before do
        sign_in user
        get new_employee_work_from_home_path(user)
      end

      it 'assigns a new WorkFromHome to work_from_home' do
        expect(assigns(:work_from_home)).to be_a_new(WorkFromHome)
      end
    end
  end

  describe '#create' do
    let(:valid_wfh) { { work_from_home: { date: Date.current, status: 'not_approved' } } }
    let(:invalid_wfh) { { work_from_home: { date: '', status: 'not_approved' } } }

    context "when user is an hr or employee" do
      before do
        sign_in user
        ActionController::Base.allow_forgery_protection = false
      end

      it 'creates a WorkFromHome record if params are valid' do
        expect {
          post employee_work_from_homes_path(user), params: valid_wfh
        }.to change(WorkFromHome, :count).by(1)
      end
      
      it 'does not create a WorkFromHome record on invalid params' do
        expect {
          post employee_work_from_homes_path(user), params: invalid_wfh
        }.to change(WorkFromHome, :count).by(0)
      end
    end
  end
end
