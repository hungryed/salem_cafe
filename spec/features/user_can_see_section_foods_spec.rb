require 'spec_helper'

feature 'user can see section foods' do
  let!(:food) { FactoryGirl.create(:food) }

  scenario 'visiting sections page shows foods' do
    visit root_path
    click_on "view_sections"
    click_on food.section.name
    expect(page).to have_content food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
    click_on food.name
    expect(page).to have_content food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
  end

  scenario 'authenticated user sees food item' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit root_path
    click_on "view_sections"
    click_on food.section.name
    click_on food.name
    expect(page).to have_content food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
  end
end
