require 'spec_helper'

feature 'worker or admin creates a food category' do
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let(:user) { FactoryGirl.create(:user) }
  let!(:section) { FactoryGirl.create(:section) }

  scenario 'worker for a section creates a category relating to section' do
    worker_sign_in_as(worker)
    visit root_path
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'
    click_on 'Add New Category'
    fill_in 'Name', with: 'Side'
    fill_in 'Description', with: 'Small Foods'
    click_on 'Create Food category'

    expect(page).to have_content 'Category created successfully'
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'

    expect(page).to have_content 'Side'
  end

  scenario 'admin adds a category to a section' do
    admin_sign_in_as(admin)
    visit root_path
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'
    click_on 'Add New Category'
    fill_in 'Name', with: 'Side'
    fill_in 'Description', with: 'Small Foods'
    click_on 'Create Food category'

    expect(page).to have_content 'Category created successfully'
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'

    expect(page).to have_content 'Side'
  end

  scenario 'worker fills out form with invalid attributes' do
    worker_sign_in_as(worker)
    visit root_path
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'
    click_on 'Add New Category'
    click_on 'Create Food category'
    expect_presence_error_for('food_category', :name)
  end

  scenario "customer can't see category sections pages" do
    sign_in_as(user)
    visit root_path
    click_on "view_sections"
    click_on section.name

    expect(page).to_not have_content 'Food Categories'

    visit section_food_categories_path(section)
    expect(page).to have_content 'You do not have permission to access that page'
  end

  scenario "customer can't add or edit category pages" do
    sign_in_as(user)
    food_category = FactoryGirl.create(:food_category, section: section)
    visit new_section_food_category_path(section)
    expect(page).to have_content 'You do not have permission to access that page'
    visit edit_section_food_category_path(section, food_category)
    expect(page).to have_content 'You do not have permission to access that page'
  end

  scenario "unauthorized user can't add or edit category pages" do
    food_category = FactoryGirl.create(:food_category, section: section)
    visit new_section_food_category_path(section)
    expect(page).to have_content 'You do not have permission to access that page'
    visit edit_section_food_category_path(section, food_category)
    expect(page).to have_content 'You do not have permission to access that page'
  end
end
