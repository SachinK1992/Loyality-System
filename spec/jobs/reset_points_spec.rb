require "rails_helper"

RSpec.describe ResetPointsJob, :type => :job do
  describe "#perform_later" do
    it "points expires every year" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        ResetPointsJob.perform_later
      }.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    it "points expires every year" do
      user = create :user, points: 100
      ActiveJob::Base.queue_adapter = :test

      expect(user.points).to eq 100

      ResetPointsJob.perform_now
      
      expect(user.reload.points).to eq 0
    end
  end
end