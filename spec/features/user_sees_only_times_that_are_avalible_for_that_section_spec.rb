require 'spec_helper'

feature 'user only sees times avalible for that section' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:breakfast) { FactoryGirl.create(:section, name: 'Breakfast',
    start_time: '7', end_time: '10') }
  let(:lunch) { FactoryGirl.create(:section, name: 'Deli',
    start_time: '11', end_time: '14') }

  scenario 'user visits section order page' do
    sign_in_as(user)
    visit root_path
    click_on "order_food"
    expect(page).to have_content 'Breakfast'
    click_on 'Breakfast'
    expect{ select '11', from: "order_arrival_time_4i" }.to raise_error
  end
end
