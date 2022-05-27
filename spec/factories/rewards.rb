FactoryBot.define do
  factory :reward do
    sequence(:reward_type) { |n| "Free Coffee reward ##{ n }" }
    association :user
  end
end
