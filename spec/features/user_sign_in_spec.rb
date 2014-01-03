require 'spec_helper'

feature 'user signs in' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'existing users can relog in' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content "Welcome Back"
      #{user.first_name.capitalize} #{user.last_name.capitalize}"
    expect(page).to_not have_content "Sign In"
  end

  scenario 'existing accounts can only be accessed with valid password' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: 'Banana'
    click_button 'Sign In'

    expect(page).to have_content 'Invalid Email or Password.'
  end

  scenario 'nonexisting accounts present nondescript errors' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'Banana'
    click_button 'Sign In'

    expect(page).to have_content 'Invalid Email or Password.'
  end
end
