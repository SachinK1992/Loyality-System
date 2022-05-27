require 'rails_helper'

feature 'Users' do
  def login(user, password)
    visit root_path
    click_on 'Sign in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_on 'Log in'

    expect(page).to have_content("Hello, #{user.email}")
  end

  scenario 'spend 100$ and earn points in same country' do
    user = create :user
    login(user, "password")
    visit root_path

    expect(page).to have_content("spend 100$")

    click_on 'spend 100$'

    expect(user.reload.spend_money).to eq 100.0
    expect(user.reload.points).to eq 10
  end

  scenario 'spend 100$ and earn points in different country' do
    user = create :user
    login(user, "password")
    visit root_path

    expect(page).to have_content("spend 100$ in foreign country")

    click_on 'spend 100$ in foreign country'

    expect(user.reload.spend_money).to eq 100.0
    expect(user.reload.points).to eq 20
  end

  scenario 'on money spend create a new transaction' do
    user = create :user
    login(user, "password")
    visit root_path

    expect(page).to have_content("spend 100$")

    click_on 'spend 100$'

    expect(user.transactions.last.amount).to eq 100.0
    expect(user.transactions.last.points).to eq 10
  end

  scenario 'end user tier updation to gold tier' do
    user = create :user, points: 990
    login(user, "password")
    visit root_path

    expect(user.user_type).to eq "standard_tier_customer"
    expect(page).to have_content("spend 100$ in foreign country")

    click_on 'spend 100$ in foreign country'

    expect(user.reload.points).to eq 1010
    expect(user.reload.user_type).to eq "gold_tier_customer"
  end

  scenario 'end user tier updation to platinum tier' do
    user = create :user, points: 4000, user_type: "gold_tier_customer"
    login(user, "password")
    visit root_path

    expect(user.user_type).to eq "gold_tier_customer"
    user.update(points: user.points+1000)

    expect(page).to have_content("spend 100$ in foreign country")

    click_on 'spend 100$ in foreign country'

    expect(user.reload.points).to eq 5020
    expect(user.reload.user_type).to eq "platinum_tier_customer"
  end

  # reward when user become gold tier customer
  scenario 'reward on become gold tier customer' do
    user = create :user, points: 990
    login(user, "password")
    visit root_path

    expect(user.user_type).to eq "standard_tier_customer"
    expect(page).to have_content("spend 100$ in foreign country")

    click_on 'spend 100$ in foreign country'

    expect(user.reload.points).to eq 1010
    expect(user.rewards.last.reward_type).to eq "lounge"
  end
end
