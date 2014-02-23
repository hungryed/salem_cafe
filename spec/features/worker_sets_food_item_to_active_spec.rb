require 'spec_helper'

feature 'worker sets food item to active' do
  let!(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let!(:food) { FactoryGirl.create(:food) }

  scenario 'worker sets food items to active' do
    food = FactoryGirl.create(:food, on_menu: false)
    worker_sign_in_as(worker)
    click_on 'Set Menu Items'
    click_on food.section.name
    check "food_#{food.id}"
    click_on "submit_#{food.section.id}"
    expect(page).to have_content "Menu updated successfully for #{food.section.name}"
  end

  scenario 'worker sets food items to inactive' do
    worker_sign_in_as(worker)
    click_on 'Set Menu Items'
    click_on food.section.name
    uncheck "food_#{food.id}"
    click_on "submit_#{food.section.id}"
    expect(page).to have_content "Menu updated successfully for #{food.section.name}"
  end

  scenario 'customer only sees active food' do
    food2 = FactoryGirl.create(:food, section: food.section, on_menu: false)
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    click_on 'order_food'
    click_on food.section.name
    expect(page).to have_content food.name
    expect(page).to_not have_content food2.name
  end
end
