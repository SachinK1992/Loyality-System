FactoryBot.define do
  factory :transaction do
    sequence(:amount) { |n| "100 ##{ n }" }
    sequence(:points) { |n| "10 ##{ n }" }
    association :user
  end
end
