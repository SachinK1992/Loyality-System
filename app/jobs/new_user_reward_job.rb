class NewUserRewardJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users = User.joins(:transactions).where(created_at: 60.days.ago...Time.now.end_of_month).distinct
    User.all.each do |user|
      total = user.transactions.sum(:amount)
      user.rewards.create(reward_type: Reward.reward_types[:movie]) if total >= 1000
    end
  end
end
