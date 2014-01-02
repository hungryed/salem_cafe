require 'spec_helper'

feature 'user signs up' do

  scenario 'valid information is supplied' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content "You're in"
    expect(page).to have_content "Sign Out"
    expect(page).to_not have_content "Sign Up"
  end

  scenario 'invalid information is supplied' do
    visit new_user_registration_path
    click_button 'Sign Up'
    expect_presence_error_for(:first_name)
    expect_presence_error_for(:last_name)
    expect_presence_error_for(:email)
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'invalid password confirmation is given' do
    visit new_user_registration_path
    fill_in 'user_password', with: 'thispassword'
    fill_in 'Password Confirmation', with: 'anotherpassword'
    click_button 'Sign Up'

    expect(page).to have_content "doesn't match"
  end
end

def expect_presence_error_for(attribute)
  within ".input.user_#{attribute.to_s}" do
    have_content "can't be blank"
  end
end
