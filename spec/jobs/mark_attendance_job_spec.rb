require 'rails_helper'

RSpec.describe MarkAttendanceJob, type: :job do
  fixtures :all
  let(:user) { users(:employee) }

  describe '#perform' do
    context 'when user has not marked attendance for the current date' do
      it 'marks the user absent' do
        expect { MarkAttendanceJob.perform_now }.to change { user.attendances.count }.by(1)
      end
    end

    context 'when user has marked attendance for the current date' do
      before do
        user.attendances.create(date: Date.current)
      end

      it 'does nothing' do
        expect { MarkAttendanceJob.perform_now }.not_to change { user.attendances.count }
      end
    end
  end
end
