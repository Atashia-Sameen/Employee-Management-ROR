require 'rails_helper'

RSpec.describe AttendancePolicy, type: :policy do
  let(:user) { create(:user) }
  let(:attendance) { create(:attendance, user: user) }
  let(:record) { attendance }

  subject { described_class }

  permissions :index? do
    it "allows access for HR" do
      hr_user = create(:user, :hr)
      expect(subject).to permit(hr_user, record)
    end

    it "allows access for managers" do
      manager_user = create(:user, :manager)
      expect(subject).to permit(manager_user, record)
    end

    it "allows access for employees" do
      expect(subject).to permit(user, record)
    end
  end

  permissions :new? do
    it "allows access for HR" do
      hr_user = create(:user, :hr)
      expect(subject).to permit(hr_user, record)
    end

    it "allows access for employees" do
      expect(subject).to permit(user, record)
    end
  end

  permissions :create? do
    it "allows access for HR" do
      hr_user = create(:user, :hr)
      expect(subject).to permit(hr_user, record)
    end

    it "allows access for employees" do
      expect(subject).to permit(user, record)
    end
  end

  describe AttendancePolicy::Scope do
    let(:policy_scope) { Pundit.policy_scope(user, Attendance) }

    context "when user is a manager" do
      let(:user) { create(:user, :manager) }

      it "returns all attendances" do
        expect(policy_scope).to include(record)
      end
    end

    context "when user is not a manager" do
      it "returns only attendances for the user" do
        expect(policy_scope).to include(record)
      end
    end
  end
end
