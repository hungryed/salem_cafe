require 'spec_helper'

feature 'user can delete their order' do
  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'user can see their order' do
    order = FactoryGirl.create(:order)
    sign_in_as(order.user)
    click_on 'My Order'
    expect(page).to have_content order.food.name
    expect(page).to have_content order.arrival_time
  end

  scenario 'user deletes their order'

  scenario 'users can only delete their own orders'
end
