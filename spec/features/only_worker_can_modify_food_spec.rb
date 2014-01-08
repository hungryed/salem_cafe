require 'spec_helper'

feature 'worker modifies food' do
  let(:user) { FactoryGirl.create(:user) }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let!(:section) { FactoryGirl.create(:section) }
  context 'authenticated worker' do
    scenario 'modifies food with valid attributes' do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'Add Food'
      fill_in 'Name', with: 'Ham'
      select section.name, from: 'Section'
      fill_in 'Description', with: 'Scrumptious'
      click_on 'Create Food'

      expect(page).to have_content "Food Item added"
    end

    scenario 'modifies food with invalid attributes' do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'Add Food'
      click_on 'Create Food'

      expect_presence_error_for('food', :name)
      expect_presence_error_for('food', :section_id)
    end
  end

  context "unauthenticated worker" do
    scenario "can't visit food edit path" do
      sign_in_as(user)
      visit root_path

      expect(page).to_not have_content 'Add Food'
      expect{ visit new_food_path }.to raise_error
    end

    scenario "can visit food description path"
  end


end
