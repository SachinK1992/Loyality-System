class UsersController < ApplicationController

	def index;	end

	def get_point
		@user = User.find_by_id(params[:id])
		@user.spend_money += 100.0
		@user.points += params[:country]=="same" ? 10 : 20
		@user.save
	end
end
