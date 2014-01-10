require 'spec_helper'

feature 'worker adds a food item' do
  let(:user) { FactoryGirl.create(:user, role: 'worker') }
  let!(:food_category) { FactoryGirl.create(:food_category) }

  context "valid worker type user" do
    scenario 'worker submits valid information' do
      worker_sign_in_as(user)
      click_on 'View Sections'
      click_on food_category.section.name
      click_on 'Add Food'
      fill_in 'Name', with: 'Chicken Brocolli Cheddar Bake'
      select food_category.name, from: 'Category'
      click_on 'Create Food'

      expect(page).to have_content "Food Item added"
    end

    scenario 'worker submits invalid information' do
      worker_sign_in_as(user)
      click_on 'View Sections'
      click_on food_category.section.name
      click_on 'Add Food'
      click_on 'Create Food'

      expect_presence_error_for('food', :name)
    end
  end

  context "invalid user" do
    scenario "unauthenticated user can't add food item" do
      visit root_path
      click_on 'View Sections'
      click_on food_category.section.name
      expect(page).to_not have_content 'Add Food'

      visit new_section_food_path(food_category.section)
      expect(page).to have_content 'You do not have permission to access that page'
    end
  end

end
