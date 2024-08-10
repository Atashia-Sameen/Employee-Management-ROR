require 'rails_helper'

RSpec.describe WorkFromHome, type: :model do
  fixtures :all

  let(:user) { users(:employee) }
  let(:wfh) { work_from_homes(:approved) }

  context 'association' do
    it 'belongs to a user' do
      expect(wfh.user).to eq(user)
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
      wfh.date = nil

      expect(wfh).not_to be_valid
    end

    it 'is not valid with a duplicate date for the same user' do
      new_wfh = user.wfh.create(date: Date.current)

      expect(new_wfh).not_to be_valid
      expect(new_wfh.errors[:date]).to include('You have already applied WFH for this date.')
    end
  end
end
