require 'spec_helper'

feature 'user can sign out' do
  scenario 'already active user signs out' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "sign_in"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_on "sign_out"

    expect(page).to have_content 'Signed out successfully'
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    expect(page).to_not have_content 'Sign Out'
  end
end
