require 'spec_helper'

feature 'user places an order' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user places an order' do
    food = FactoryGirl.create(:food)
    sign_in_as(user)
    click_on 'Order Food'
    select food.name, from: 'Food'
    # select time
    click_on 'Create Order'

    expect(page).to have_content 'Order placed successfully'
    expect(page).to have_content 'Create Order'
    expect(page).to have_content 'Sign Out'
  end

  scenario "unauthenticated user can't place an order"

  scenario "authenticated user supplies bad information"
end
