class Reward < ApplicationRecord
	enum reward_type: {
		coffee: "Free Coffee reward",
		percentage: "5\% Cash Rebate reward",
		movie: "Free Movie Tickets reward",
		lounge: "4x Airport Lounge Access Reward"
	}

	belongs_to :user
end
