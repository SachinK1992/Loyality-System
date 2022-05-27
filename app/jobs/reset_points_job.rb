class ResetPointsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.update_all(points: 0, user_type: User.user_types.keys[0])
    User.all.each do |user|
      count = user.transactions.where("amount > ?", 100).count
      user.rewards.create(reward_type: Reward.reward_types[:percentage]) if count >=10
    end
  end
end
