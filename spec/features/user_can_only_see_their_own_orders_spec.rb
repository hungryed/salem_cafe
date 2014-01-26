require 'spec_helper'

feature 'user only sees their own orders' do

  scenario "user visits another users order index" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)

    visit user_orders_path(user)
    expect(page).to have_content 'You do not have permission to access that page'
  end
end
