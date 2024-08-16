require 'rails_helper'

RSpec.describe Attendance, type: :model do
  fixtures :all

  let(:user) { users(:employee) }
  let(:attendance) { attendances(:present) }

  context 'association' do
    it 'belongs to a user' do
      expect(attendance.user).to eq(user)
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
      attendance.date = nil
      expect(attendance).not_to be_valid
    end    
  end

end
