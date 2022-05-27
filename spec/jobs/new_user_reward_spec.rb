require "rails_helper"

RSpec.describe NewUserRewardJob, :type => :job do
  # free Free Movie Tickets reward to new users
  describe "#perform_later" do
    it "new user reward" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        NewUserRewardJob.perform_later
      }.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    it "new user reward if spend more than 1000$ in 60 days" do
      user = create :user, spend_money: 900, points: 90
      ActiveJob::Base.queue_adapter = :test

      expect(user.spend_money).to eq 900
      user.update(spend_money: user.spend_money+500)
      user.update(spend_money: user.spend_money+1000)
      NewUserRewardJob.perform_now
      
      expect(user.rewards.last.reward_type).to eq "movie"
    end
  end

  describe "#perform_now" do
    it "no new user reward if spend less than 1000$ in 60 days" do
      user = create :user, spend_money: 300, points: 90
      ActiveJob::Base.queue_adapter = :test

      expect(user.spend_money).to eq 300
      user.update(spend_money: user.spend_money+500)
      NewUserRewardJob.perform_now
      
      expect(user.rewards.last).to eq nil
    end
  end
end