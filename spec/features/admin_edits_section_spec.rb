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
    expect(page).to_not have_content section.name
    expect(page).to_not have_content section.description
  end

  scenario 'admin submits invalid information' do
    admin_sign_in_as(admin)
    visit root_path
    click_on 'View Sections'
    click_on 'Edit'
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_on 'Update Section'

    expect_presence_error_for('section', :name)
    expect_presence_error_for('section', :description)
  end

  scenario "worker can't edit sections" do
    worker_sign_in_as(worker)
    visit root_path
    click_on 'View Sections'
    expect(page).to_not have_content 'Edit'
    expect{ visit edit_sections_path(section) }.to raise_error
  end

  scenario "customer can't edit sections" do
    sign_in_as(user)
    visit root_path
    click_on 'View Sections'
    expect(page).to_not have_content 'Edit'
    expect{ visit edit_sections_path(section) }.to raise_error
  end
end
