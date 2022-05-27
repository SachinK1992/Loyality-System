set :output, "log/cron.log"

every 1.day, at: '7:00 am' do
  runner "BirthdayRewardJob.perform_later"
end

every 1.year, at: "January 1st, 12:00AM"  do
  runner "ResetPointsJob.perform_later"
end

every 1.month, at: "12:00AM"  do
  runner "MonthlyPointsJob.perform_later"
end

every 3.months do
	runner "QuaterlyBonusJob.perform_later"
end

every 1.day, at: '9:00 am' do
	runner "NewUserRewardJob.perform_later"
end