require "rails_helper"

RSpec.describe QuarterlyBonusJob, :type => :job do
  # quaterly bonus to custmers
  describe "#perform_later" do
    it "quaterly bonus of 100 points" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        QuarterlyBonusJob.perform_later
      }.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    it "quaterly bonus of 100 points if spend more than 2000" do
      user = create :user, points: 100, spend_money: 2000
      ActiveJob::Base.queue_adapter = :test

      expect(user.points).to eq 100

      QuarterlyBonusJob.perform_now
      
      expect(user.reload.points).to eq 200
    end
  end

  describe "#perform_now" do
    it "no quaterly bonus of 100 points if spend less than 2000" do
      user = create :user, points: 100, spend_money: 1000
      ActiveJob::Base.queue_adapter = :test

      expect(user.points).to eq 100

      QuarterlyBonusJob.perform_now
      
      expect(user.reload.points).not_to eq 200
    end
  end
end