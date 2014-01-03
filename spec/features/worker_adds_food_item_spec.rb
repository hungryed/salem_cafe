require 'spec_helper'

feature 'worker adds a food item' do
  let(:user) { FactoryGirl.create(:user) }

  context "valid worker type user" do
    scenario 'worker submits valid information' do
      sign_in_as(user)
      click_on 'Add Food'
      fill_in 'Name', with: 'Chicken Brocolli Cheddar Bake'
      click_on 'Create Food'

      expect(page).to have_content "Food Item added"
      expect(page).to have_content 'Add Food'
    end

    scenario 'worker submits invalid information' do
      sign_in_as(user)
      click_on 'Add Food'
      click_on 'Create Food'

      expect_presence_error_for('food', :name)
    end
  end

  context "invalid user" do
    scenario "unauthenticated user can't add food item" do
      visit root_path
      click_on 'Add Food'

      expect(page).to have_content "Only workers can add food"
    end
  end

end
