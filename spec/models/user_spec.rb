require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :all

  let(:user) { users(:employee) }
  let(:hr) { users(:hr) }
  let(:organization) { organizations(:techieminions) }

  context 'associations' do
    it 'belongs to an organization' do
      expect(user.organization).to eq(organization)
    end

    it 'has many leaves' do
      expect(user).to respond_to(:leaves)
    end

    it 'has many attendances' do
      expect(user).to respond_to(:attendances)
    end

    it 'has many work_from_homes' do
      expect(user).to respond_to(:work_from_homes)
    end

    it 'has one organization' do
      expect(hr.own_organization).to eq(organization)
    end
  end

  context 'enum' do
    it 'has the correct role values' do
      expect(User.roles[:hr]).to eq(0)
      expect(User.roles[:manager]).to eq(1)
      expect(User.roles[:employee]).to eq(2)
    end
  end

  context 'validations' do
    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end
  end
  
  context 'devise' do
    it 'includes devise modules' do
      expect(User.devise_modules).to include(:database_authenticatable, :registerable, :recoverable, :rememberable, :validatable)
    end
  end

  context 'callback' do
    it 'strips whitespaces from name' do
      user.valid?
      expect(user.name).to eq('Employee')
    end

    it 'strips whitespaces from email' do
      user.valid?
      expect(user.email).to eq('employee@example.com')
    end
  end
  
end
