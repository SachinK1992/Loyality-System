require "rails_helper"

RSpec.describe BirthdayRewardJob, :type => :job do
  # provide free coffee reward on customer birthday
  describe "#perform_later" do
    it "reward on birthday" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        BirthdayRewardJob.perform_later
      }.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    it "reward on birthday" do
      user = create :user, dob: Date.today
      ActiveJob::Base.queue_adapter = :test
      BirthdayRewardJob.perform_now
      
      expect(user.rewards.last.reward_type).to eq "coffee"
    end
  end
end