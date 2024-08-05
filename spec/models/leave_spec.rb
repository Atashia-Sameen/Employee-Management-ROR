require 'rails_helper'

RSpec.describe Leave, type: :model do
  before do
    @user = User.new(name: 'User', email: 'user@example.com')
    @leave = @user.leaves.new(date: Date.today, type: :casual, status: :not_approved)
  end

  context 'association' do
    it 'belongs to a user' do
      expect(@leave.user).to eq(@user)
    end
  end

  context 'enum' do
    it 'has the correct type values' do
      expect(Leave.types[:casual]).to eq(0)
      expect(Leave.types[:sick]).to eq(1)
    end

    it 'has the correct status values' do
      expect(Leave.statuses[:not_approved]).to eq(0)
      expect(Leave.statuses[:approved]).to eq(1)
    end
  end
  
  context 'validations' do
    it 'is not valid without a date' do
      @leave.date = nil
      expect(@leave).not_to be_valid
    end

    it 'is not valid with the same date for a user' do
      @leave.save!
      new_leave = @user.leaves.new(date: Date.today, type: :sick)
      expect(new_leave).not_to be_valid
      expect(new_leave.errors[:date]).to include('You have already applied leave for this date.')
    end
  end
  
end
