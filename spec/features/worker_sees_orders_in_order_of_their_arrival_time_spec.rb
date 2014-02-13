require 'spec_helper'

feature 'worker sees orders in the order of arrival time' do
  let!(:worker) { FactoryGirl.create(:user, role: 'worker') }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'worker sees orders in the correct order' do
    worker_sign_in_as(worker)
    order= FactoryGirl.create(:order)
    order2 = create_order(section: order.section,
      food: order.foods.first, arrival_time: '11:30')
    order3 = create_order(section: order.section,
      food: order.foods.first, arrival_time: '12:00')
    click_on "view_sections"
    click_on order.section.name
    click_on 'Orders'
    order.clean_arrival_time.should_not appear_before(order2.clean_arrival_time)
    order.clean_arrival_time.should_not appear_before(order3.clean_arrival_time)
    order2.clean_arrival_time.should appear_before(order3.clean_arrival_time)
  end
end
