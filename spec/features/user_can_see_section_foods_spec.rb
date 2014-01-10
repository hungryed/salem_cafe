require 'spec_helper'

feature 'user can see section foods' do
  let!(:food) { FactoryGirl.create(:food) }

  scenario 'visiting sections page shows foods' do
    visit root_path
    click_on 'View Sections'
    click_on food.section.name
    expect(page).to have_content food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
  end
end
