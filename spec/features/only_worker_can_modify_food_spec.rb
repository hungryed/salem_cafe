require 'spec_helper'

feature 'worker modifies food' do
  let(:user) { FactoryGirl.create(:user) }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let!(:section) { FactoryGirl.create(:section) }
  context 'authenticated worker' do
    scenario 'creates food with valid attributes' do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'Add Food'
      fill_in 'Name', with: 'Ham'
      select section.name, from: 'Section'
      fill_in 'Description', with: 'Scrumptious'
      click_on 'Create Food'

      expect(page).to have_content "Food Item added"
    end

    scenario 'creates food with invalid attributes' do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'Add Food'
      click_on 'Create Food'

      expect_presence_error_for('food', :name)
      expect_presence_error_for('food', :section_id)
    end

    scenario 'modifies food with valid attributes' do
      food = FactoryGirl.create(:food)
      worker_sign_in_as(worker)
      visit root_path
      click_on 'See Foods'
      click_on food.name
      click_on 'Edit'
      fill_in 'Name', with: 'Potatoe'
      fill_in 'Description', with: 'Starch'
      click_on 'Update Food'

      expect(page).to have_content 'Food Item updated successfully'
    end

    scenario 'modifies food with invalid attributes' do
      food = FactoryGirl.create(:food)
      worker_sign_in_as(worker)
      visit root_path
      click_on 'See Foods'
      click_on food.name
      click_on 'Edit'
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      select "", from: 'Section'
      click_on 'Update Food'

      expect_presence_error_for('food', :name)
      expect_presence_error_for('food', :section_id)
    end
  end

  context "unauthenticated worker" do
    scenario "can't visit food edit path" do
      sign_in_as(user)
      visit root_path

      expect(page).to_not have_content 'Add Food'
      visit new_food_path
      expect(page).to have_content 'Naw Son'
    end

    scenario "can visit food description path" do
      food = FactoryGirl.create(:food)
      sign_in_as(user)
      visit root_path

      click_on 'See Foods'

      expect(page).to have_content food.name
      click_on food.name
      expect(page).to have_content food.name
      expect(page).to have_content food.description
      expect(page).to have_content food.section.name
    end
  end


end
