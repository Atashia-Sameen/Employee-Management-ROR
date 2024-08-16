require 'rails_helper'

RSpec.describe AttendancePolicy, type: :policy do
  fixtures :all

  let(:hr) { users(:hr) }
  let(:employee) { users(:employee) }
  let(:manager) { users(:manager) }

  let(:hr_policy) { AttendancePolicy.new(hr, hr.attendances) }
  let(:employee_policy) { AttendancePolicy.new(employee, employee.attendances) }
  let(:manager_policy) { AttendancePolicy.new(manager, Attendance) }

  describe '#index?' do
    it "allows access for HR" do
      expect(hr_policy.index?).to be_truthy
    end

    it "allows access for managers" do
      expect(employee_policy.index?).to be_truthy
    end
    
    it "allows access for employees" do
      expect(manager_policy.index?).to be_truthy
    end
  end

  describe '#new?' do
    it "allows access for HR" do
      expect(hr_policy.new?).to be_truthy
    end

    it "allows access for employees" do
      expect(employee_policy.new?).to be_truthy
    end

    it "does not allow access for managers" do
      expect(manager_policy.new?).to be_falsy
    end
  end

  describe '#create?' do
    it "allows access for HR" do
      expect(hr_policy.new?).to be_truthy
    end

    it "allows access for employees" do
      expect(employee_policy.new?).to be_truthy
    end

    it "does not allow access for managers" do
      expect(manager_policy.new?).to be_falsy
    end
  end

  describe 'Scope' do
    context "when user is an hr" do
      it "returns only attendances of current user" do
        scope = AttendancePolicy::Scope.new(hr, Attendance.all).resolve

        expect(scope).to match_array(hr.attendances)
      end
    end
    
    context "when user is an employee" do
      it "returns only attendances of current user" do
        scope = AttendancePolicy::Scope.new(employee, Attendance.all).resolve
    
        expect(scope).to match_array(employee.attendances)
      end
    end
    
    context "when user is a manager" do
      it "returns all attendances" do
        scope = AttendancePolicy::Scope.new(manager, Attendance.all).resolve
    
        expect(scope).to match_array(Attendance.all)
      end
    end
  end
end
