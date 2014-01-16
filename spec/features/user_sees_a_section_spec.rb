require 'spec_helper'

feature 'user sees a section' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:food) { FactoryGirl.create(:food) }

  scenario 'authenticated user can see section foods' do
    sign_in_as(user)
    click_on "view_sections"
    click_on food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
  end

  scenario 'unauthenticated user can see section foods' do
    visit root_path
    click_on "view_sections"
    click_on food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
  end
end
