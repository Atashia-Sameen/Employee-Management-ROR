require 'rails_helper'

RSpec.describe Organization, type: :model do
  before do
    @organization = Organization.new(name: 'organization abc', creator_id: 1)
  end

  context 'association' do
    it 'has many users' do
      expect(@organization).to respond_to(:users)
    end
  end

  context 'validations' do
    it 'is not valid without a name' do
      @organization.name = nil
      expect(@organization).not_to be_valid
    end

    it 'is not valid without a creator_id' do
      @organization.creator_id = nil
      expect(@organization).not_to be_valid
    end
  end
  
end
