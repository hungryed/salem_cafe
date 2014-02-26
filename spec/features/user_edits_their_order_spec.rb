require 'spec_helper'

feature 'user edits their order' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:section) { FactoryGirl.create(:section) }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'user can edit their order' do
    food_category = FactoryGirl.create(:food_category, section: section)
    food = FactoryGirl.create(:food,
      food_category: food_category,
      section: section)
    order = create_order(
      section: section, food: food)
    user = order.user
    sign_in_as(user)
    visit root_path
    click_on "my_orders"
    expect(page).to have_content order.display_string
    click_on 'Edit Order'
    within '#order_arrival_time_4i' do
      select '1 PM'
    end
    click_on 'Update Order'

    expect(page).to have_content 'Order changed successfully'

  end

  scenario 'user edits their order with bad info' do
    food_category = FactoryGirl.create(:food_category,
      section: section)
    food = FactoryGirl.create(:food,
      food_category: food_category,
      section: section)
    order = create_order(
      section: section,
      food: food)
    user = order.user
    sign_in_as(user)
    visit root_path
    click_on "my_orders"
    expect(page).to have_content order.display_string
    Timecop.freeze(2014,1,4,12,0,0)
    click_on 'Edit Order'
    select '', from: food_category.name
    within '#order_arrival_time_4i' do
      select '11 AM'
    end
    click_button 'Update Order'

    expect(page).to have_content 'Arrival must be a future time'
    expect(page).to have_content "can't be blank"
  end
end
