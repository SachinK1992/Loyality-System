FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "Jane ##{ n }" }
    sequence(:last_name) { |n| "Doe ##{ n }" }
    sequence(:email) { |n| "jane.doe.#{ n }@example.com" }
    sequence(:user_type) { |n| "#{User.user_types.keys[0]}" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
