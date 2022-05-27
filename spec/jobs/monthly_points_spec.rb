require "rails_helper"

RSpec.describe MonthlyPointsJob, :type => :job do
  # give free coffee reward based on monthly points
  describe "#perform_later" do
    it "mothly reward" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        MonthlyPointsJob.perform_later
      }.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    it "mothly reward if having more than 100 points" do
      user = create :user, points: 10, spend_money: 100
      ActiveJob::Base.queue_adapter = :test

      expect(user.points).to eq 10
      user.update(points: user.points+90, spend_money: 400)
      MonthlyPointsJob.perform_now
      
      expect(user.rewards.last.reward_type).to eq "coffee"
    end
  end

  describe "#perform_now" do
    it "no mothly reward if having less than 100 points" do
      user = create :user, points: 10, spend_money: 100 
      ActiveJob::Base.queue_adapter = :test

      expect(user.points).to eq 10
      MonthlyPointsJob.perform_now
      
      expect(user.rewards.last).to eq nil
    end
  end
end