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
      check 'Receive Text Notifications'
      fill_in 'user_password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign Up'

    end
  end
end
