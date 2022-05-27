class MonthlyPointsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Users.all.each do |user|
      points = user.transactions.where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month).sum(:points)
      user.rewards.create(reward_type: Reward.reward_types[:coffee]) if points >= 100
  end
end
