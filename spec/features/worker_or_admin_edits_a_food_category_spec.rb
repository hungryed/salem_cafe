require 'spec_helper'

feature 'worker or admin edits a food category' do
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let(:user) { FactoryGirl.create(:user) }
  let!(:section) { FactoryGirl.create(:section) }

  scenario 'worker edits category with valid attributes' do
    food_category = FactoryGirl.create(:food_category, section: section)
    worker_sign_in_as(worker)
    visit root_path
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'
    click_on "edit_food_category_#{food_category.id}"
    fill_in 'Name', with: 'Side'
    check 'Customer can have multiple in an order'
    fill_in 'Description', with: 'Main Course'
    click_on 'Update Food category'

    expect(page).to have_content 'Category updated successfully'

    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'

    expect(page).to have_content 'Side'
    expect(page).to_not have_content food_category.name
  end

  scenario 'worker edits category with invalid attributes' do
    food_category = FactoryGirl.create(:food_category, section: section)
    worker_sign_in_as(worker)
    visit root_path
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'
    click_on "edit_food_category_#{food_category.id}"
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_on 'Update Food category'

    expect_presence_error_for('food_category', :name)
    visit root_path
    click_on "view_sections"
    click_on section.name
    click_on 'Food Categories'

    expect(page).to_not have_content 'Side'
    expect(page).to have_content food_category.name
  end

end
