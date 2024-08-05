require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before do
    @user = User.new(name: 'User', email: 'user@example.com')
    @attendance = @user.attendances.new(date: Date.today, status: :present)
  end

  context 'association' do
    it 'belongs to a user' do
      expect(@attendance.user).to eq(@user)
    end
  end

  context 'enum' do
    it 'has the correct status values' do
      expect(Attendance.statuses[:absent]).to eq(0)
      expect(Attendance.statuses[:present]).to eq(1)
    end
  end

  context 'validations' do
    it 'is not valid without a date' do
      @attendance.date = nil
      expect(@attendance).not_to be_valid
    end    
  end

end
