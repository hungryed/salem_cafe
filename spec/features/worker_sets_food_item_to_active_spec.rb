require 'spec_helper'

feature 'worker sets food item to active' do
  let!(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let!(:food) { FactoryGirl.create(:food, on_menu: false) }

  scenario 'worker sets food items to active' do
    worker_sign_in_as(worker)
    click_on 'Set Menu Items'
    click_on food.section.name
    check "food_#{food.id}"
    click_on "submit_#{food.section.id}"
    expect(page).to have_content "Menu updated successfully for #{food.section.name}"
  end

  scenario 'worker sets food items to inactive'

  scenario 'customer only sees active food'
end
