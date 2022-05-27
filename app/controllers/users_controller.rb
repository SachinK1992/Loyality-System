class UsersController < ApplicationController
	after_action :user_type_check, only: [:get_point]

	def index;	end

	def get_point
		@user = User.find_by_id(params[:id])
		@user.spend_money += 100.0
		@user.points += params[:country]=="same" ? 10 : 20
		@user.save
	end

	private

	def user_type_check
		if @user.user_type == User.user_types.keys[0] && @user.points >= 1000
			@user.update(user_type: User.user_types.keys[1])
			user.rewards.create(reward_type: Reward.reward_types[:lounge])
		elsif @user.user_type == User.user_types.keys[1] && @user.points >= 5000
			@user.update(user_type: User.user_types.keys[2])
		end
	end
end
