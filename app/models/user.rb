class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: {
    standard_tier_customer: "standard tier customer",
    gold_tier_customer: "gold tier customer",
    platinum_tier_customer: "platinum tier customer",
  }
end
