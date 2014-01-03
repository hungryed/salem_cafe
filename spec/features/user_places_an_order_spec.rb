require 'spec_helper'

feature 'user places an order' do

  scenario 'authenticated user places an order' do
    visit root_path
    click_on 'Sign In'
  end

  scenario "unauthenticated user can't place an order"

  scenario "authenticated user supplies bad information"
end
