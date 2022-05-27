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

  after_save :create_transaction

  has_many :rewards, dependent: :destroy
  has_many :transactions, dependent: :destroy

  private

  def create_transaction
    return unless saved_change_to_spend_money?
    amount = spend_money - previous_changes[:spend_money].first
    point = points - previous_changes[:points].first if saved_change_to_points?
    self.transactions.create!(amount: amount, points: point)
  end
end
