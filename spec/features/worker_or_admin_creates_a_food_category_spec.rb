require 'spec_helper'

feature 'worker or admin creates a food category' do
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let(:user) { FactoryGirl.create(:user) }
  let!(:section) { FactoryGirl.create(:section) }

  scenario 'worker for a section creates a category relating to section' do
    worker_sign_in_as(worker)
    visit root_path
    click_on 'View Sections'
    click_on 'Food Categories'
    click_on 'Add New Category'
    fill_in 'Name', with: 'Side'
    click_on 'Create Category'

    expect(page).to have_content 'Category created successfully'
    click_on 'View Sections'
    click_on section.name
    click_on 'Food Categories'

    expect(page).to have_content 'Side'
  end

  scenario 'admin adds a category to a section'

  scenario 'worker fills out form with invalid attributes'

  scenario "customer can't see category sections pages"

  scenario "customer can't add or edit category pages"
end
