require 'spec_helper'

feature 'user edits their profile spec' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user edits with valid information' do
    sign_in_as(user)
    visit root_path
    click_on 'My Profile'
    click_on 'Edit Profile'
    fill_in 'First Name', with: 'Banana'
    fill_in 'Last Name', with: 'Jefferson'
    fill_in 'Email', with: 'banana.jefferson@banana.com'
    click_on 'Update Profile'
    expect(page).to have_content 'Profile updated successfully'
    expect(page).to have_content 'Banana'
    expect(page).to have_content 'Jefferson'
    expect(page).to have_content 'banana.jefferson@banana.com'
  end

  scenario 'user edits with invalid information' do
    sign_in_as(user)
    visit edit_user_path(user)
    fill_in 'First Name', with: ''
    fill_in 'Last Name', with: ''
    fill_in 'Email', with: 'banana@banana'
    click_on 'Update Profile'
    expect_presence_error_for(:user, :first_name)
    expect_presence_error_for(:user, :last_name)
    expect(page).to have_content 'Emailis invalid'
  end
end
