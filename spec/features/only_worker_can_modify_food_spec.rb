require 'spec_helper'

feature 'worker modifies food' do
  let(:user) { FactoryGirl.create(:user) }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let!(:food_category) { FactoryGirl.create(:food_category) }

  context 'authenticated worker' do
    scenario 'creates food with valid attributes' do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'View Sections'
      click_on food_category.section.name
      click_on 'Add Food'
      fill_in 'Name', with: 'Ham'
      select food_category.name, from: 'Category'
      fill_in 'Description', with: 'Scrumptious'
      click_on 'Create Food'

      expect(page).to have_content "Food Item added"
    end

    scenario 'creates food with invalid attributes' do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'View Sections'
      click_on food_category.section.name
      click_on 'Add Food'
      click_on 'Create Food'

      expect_presence_error_for('food', :name)
      expect_presence_error_for('food', :food_category_id)
    end

    scenario 'modifies food with valid attributes' do
      food = FactoryGirl.create(:food, food_category: food_category)
      worker_sign_in_as(worker)
      visit root_path
      click_on 'View Sections'
      click_on food_category.section.name
      click_on food.name
      click_on 'Edit'
      fill_in 'Name', with: 'Potatoe'
      fill_in 'Description', with: 'Starch'
      click_on 'Update Food'

      expect(page).to have_content 'Food Item updated successfully'
    end

    scenario 'modifies food with invalid attributes' do
      food = FactoryGirl.create(:food, food_category: food_category)
      worker_sign_in_as(worker)
      visit root_path
      click_on 'View Sections'
      click_on food_category.section.name
      click_on food.name
      click_on 'Edit'
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      select "", from: 'Category'
      click_on 'Update Food'

      expect_presence_error_for('food', :name)
      expect_presence_error_for('food', :food_category_id)
    end
  end

  context "unauthenticated worker" do
    scenario "can't visit food edit path" do
      food = FactoryGirl.create(:food)
      sign_in_as(user)
      visit root_path
      click_on 'View Sections'
      click_on "section_#{food.section.id}"
      click_on food.name

      expect(page).to_not have_content 'Edit'
      visit new_section_food_path(food.food_category.section)
      expect(page).to have_content 'Naw Son'
    end

    scenario "can visit food description path" do
      food = FactoryGirl.create(:food)
      sign_in_as(user)
      visit root_path
      click_on 'View Sections'
      click_on "section_#{food.section.id}"

      expect(page).to have_content food.name
      click_on food.name
      save_and_open_page
      expect(page).to have_content food.name
      expect(page).to have_content food.description
      expect(page).to have_content food.section.name
    end
  end


end
