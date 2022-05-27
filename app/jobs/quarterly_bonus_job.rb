class QuarterlyBonusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.each do |user|
      total_amount = user.transactions.where(created_at: 3.months.ago..Time.now.end_of_month).sum(:amount)
      user.update_attribute(:points, user.points+100) if total_amount >= 2000
    end
  end
end
