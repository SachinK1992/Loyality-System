class PointsCalculator

	def initialize(user, country)
		@user = user
		@country = country
	end

	def self.call(*args, &block)
		new(*args, &block).update_points
	end


	def update_points
		@user.spend_money += 100.0
		@user.points += @country=="same" ? 10 : 20
		@user.save
	end
end