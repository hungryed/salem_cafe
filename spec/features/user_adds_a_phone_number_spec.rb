require 'spec_helper'

feature 'user adds a phone number' do
  context "user with phone number" do
    scenario 'user signs up with phone number' do
      visit root_path
      click_on 'sign_up'
      fill_in 'First Name', with: 'Banana'
      fill_in 'Last Name', with: 'Jefferson'
      fill_in 'Email', with: 'banana.jefferson@banana.com'
      fill_in 'Phone Number', with: '1118675309'
      check 'Receive Text Notifications when order is in progress'
      fill_in 'user_password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign Up'

      expect(page).to have_content "You're in"
    end

    scenario 'user updates their account with a phone number' do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit root_path
      click_on 'My Profile'
      click_on 'Edit'
      fill_in 'Phone Number', with: '1111111111'
      check 'Receive Text Notifications when order is in progress'
      click_on 'Update Profile'

      expect(page).to have_content "Profile updated successfully"
    end
  end

  scenario 'user updates with bad information' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit root_path
    click_on 'My Profile'
    click_on 'Edit'
    fill_in 'Phone Number', with: '111111'
    check 'Receive Text Notifications when order is in progress'
    click_on 'Update Profile'

    expect(page).to have_content "Phone Number must be 10 digits"
  end
end
