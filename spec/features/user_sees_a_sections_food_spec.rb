require 'spec_helper'

feature 'user sees a sections food' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user views sections food' do
    food = FactoryGirl.create(:food)
    sign_in_as(user)
    click_on 'view_sections'
    click_on food.section.name
    expect(page).to have_content food.name
    expect(page).to have_content food.description
  end
end
