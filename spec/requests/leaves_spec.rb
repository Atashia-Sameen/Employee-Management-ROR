require 'rails_helper'

RSpec.describe "Leaves", type: :request do
  fixtures :all
  
  let(:user) { users(:employee) }
  let(:manager) { users(:manager) }
  let(:leave) {leaves(:sick)}

  before do
  end

  describe '#index' do
    context "when user is an employee" do
      before do
        sign_in user
        get employee_leaves_path(user)
      end

      it 'assigns the user leaves to leaves' do
        expect(assigns(:leaves)).to include(leave)
      end
    end

    context "when user is a manager" do
      before do
        sign_in manager
        get employee_leaves_path(manager)
      end

      it 'assigns all leaves to leaves' do
        expect(assigns(:leaves)).to include(leave)
      end
    end
  end

  describe '#new' do
    before do
      sign_in user
      get new_employee_leave_path(user)
    end

    it 'assigns a new Leave to leave' do
      expect(assigns(:leave)).to be_a_new(Leave)
    end
  end

  describe '#create' do
    let(:valid_leave) { { leave: { date: Date.current, type: 'sick', status: 'approved' } } }
    let(:invalid_leave) { { leave: { date: '', type: '', status: '' } } }

    context "with valid parameters" do
      before do
        sign_in user
        ActionController::Base.allow_forgery_protection = false
      end

      it 'creates a new leave record' do
        expect {
          post employee_leaves_path(user), params: valid_leave
        }.to change(Leave, :count).by(1)
      end
    end

    context "with invalid parameters" do
      before do
        sign_in user
      end

      it 'does not create a new leave record' do
        expect {
          post employee_leaves_path, params: invalid_leave
        }.to change(Leave, :count).by(0)
      end
    end
  end

  describe '#update' do
    context "when user is a manager" do
      before do
        sign_in manager
        patch employee_leave_path(leave), params: { leave: { status: 'approved' } }
      end

      it 'updates the leave status' do
        expect(leave.status).to eq('approved')
      end
    end

    context "when user is not a manager" do
      before do
        sign_in user
        patch employee_leave_path(leave), params: { leave: { status: 'approved' } }
      end

      it 'does not update the leave status' do
        expect(leave.status).to eq('approved')
      end
    end
  end
end
