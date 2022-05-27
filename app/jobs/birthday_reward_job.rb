class BirthdayRewardJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users = User.where('EXTRACT(month FROM dob) = ? AND EXTRACT(day FROM dob) = ?', Date.today.month, Date.today.day).order("created_at DESC")
    users.each do |user|
      user.rewards.create(reward_type: Reward.reward_types[:coffee])
    end
  end
end
