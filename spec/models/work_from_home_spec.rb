require 'rails_helper'

RSpec.describe WorkFromHome, type: :model do
  before do
    @user = User.new(
      name: 'User',
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password',
      role: :employee
    )
    @work_from_home = @user.work_from_homes.new(date: Date.today, status: :not_approved)
  end

  context 'association' do
    it 'belongs to a user' do
      expect(@work_from_home.user).to eq(@user)
    end
  end

  context 'enum' do
    it 'has the correct status values' do
      expect(Leave.statuses[:not_approved]).to eq(0)
      expect(Leave.statuses[:approved]).to eq(1)
    end
  end

  context 'validations' do
    it 'is not valid without a date' do
      @work_from_home.date = nil
      expect(@work_from_home).not_to be_valid
    end

    it 'is not valid with a duplicate date for the same user' do
      @work_from_home.save
      new_wfh = @user.work_from_homes.new(date: @work_from_home.date)
      expect(new_wfh).not_to be_valid
      expect(new_wfh.errors[:date]).to include('You have already applied WFH for this date.')
    end
  end
end
