require 'spec_helper'

feature 'admin edits section' do
  let!(:section) { FactoryGirl.create(:section) }
  let(:admin) { FactoryGirl.create(:user, role: 'admin')  }
  let(:worker) { FactoryGirl.create(:user, role: 'worker')  }
  let(:user) { FactoryGirl.create(:user)}

  scenario 'admin submits valid information' do
    admin_sign_in_as(admin)
    visit root_path
    click_on 'View Sections'
    click_on 'Edit'
    fill_in 'Name', with: 'Hot Line'
    fill_in 'Description', with: 'Tasty foods'
    click_on 'Update Section'

    expect(page).to have_content 'Hot Line'
    expect(page).to have_content 'Tasty foods'
  end

  scenario 'admin submits invalid information'

  scenario "worker can't edit sections"

  scenario "customer can't edit sections"
end
