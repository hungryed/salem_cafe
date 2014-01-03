require 'spec_helper'

feature 'user places an order' do
  let(:user) { FactoryGirl.create(:user) }
  scenario 'authenticated user places an order' do
    sign_in_as(user)
    click_on 'Order Food'

  end

  scenario "unauthenticated user can't place an order"

  scenario "authenticated user supplies bad information"
end
