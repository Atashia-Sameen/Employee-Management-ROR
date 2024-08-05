require 'rails_helper'

RSpec.describe "Leaves", type: :request do
  before do
    @user = User.create!(name: 'User', email: 'user@example.com', password: 'password', role: 'employee')
    @manager = User.create!(name: 'Manager', email: 'manager@example.com', password: 'password', role: 'manager')
    @leave = @user.leaves.create!(date: Date.today, type: 'sick', status: 'approved')
  end

  describe 'GET /index' do
    context "when user is an employee" do
      before do
        sign_in @user
        get employee_leaves_path
      end

      it 'assigns the user leaves to @leaves' do
        expect(assigns(:leaves)).to include(@leave)
      end
    end

    context "when user is a manager" do
      before do
        sign_in @manager
        get employee_leaves_path
      end

      it 'assigns all leaves to @leaves' do
        expect(assigns(:leaves)).to include(@leave)
      end
    end
  end

  describe 'GET /show' do
    before do
      sign_in @user
      get employee_leave_path(@leave)
    end

    it 'assigns the requested leave to @leave' do
      expect(assigns(:leave)).to eq(@leave)
    end
  end

  describe 'GET /new' do
    before do
      sign_in @user
      get new_employee_leave_path
    end

    it 'assigns a new Leave to @leave' do
      expect(assigns(:leave)).to be_a_new(Leave)
    end
  end

  describe 'POST /create' do
    let(:valid_leave) { { leave: { date: Date.today, type: 'sick', status: 'approved' } } }
    let(:invalid_leave) { { leave: { date: '', type: '', status: '' } } }

    context "with valid parameters" do
      before do
        sign_in @user
      end

      it 'creates a new leave record' do
        expect {
          post employee_leaves_path, params: valid_leave
        }.to change(Leave, :count).by(1)
      end
    end

    context "with invalid parameters" do
      before do
        sign_in @user
      end

      it 'does not create a new leave record' do
        expect {
          post employee_leaves_path, params: invalid_leave
        }.to change(Leave, :count).by(0)
      end
  end

  describe 'PATCH /update' do
    context "when user is a manager" do
      before do
        sign_in @manager
        patch employee_leave_path(@leave), params: { leave: { status: 'approved' } }
      end

      it 'updates the leave status' do
        @leave.reload
        expect(@leave.status).to eq('approved')
      end
    end

    context "when user is not a manager" do
      before do
        sign_in @user
        patch employee_leave_path(@leave), params: { leave: { status: 'approved' } }
      end

      it 'does not update the leave status' do
        @leave.reload
        expect(@leave.status).to eq('approved')
      end
    end
  end
end
