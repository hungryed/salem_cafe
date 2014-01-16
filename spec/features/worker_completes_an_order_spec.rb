require 'spec_helper'

feature 'worker completes an order' do
  let(:order) { FactoryGirl.create(:order) }
  let!(:worker) { FactoryGirl.create(:user) }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,7,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'worker completes an order' do
    order2 = FactoryGirl.create(:order, section: order.section)
    worker_sign_in_as(worker)
    click_on "view_sections"
    click_on order.section.name
    click_on 'Orders'
    click_on "completed_#{order.id}"

    expect(page).to have_content order2.clean_arrival_time
    expect(page).to have_content order2.food.name
  end

  scenario 'worker completes an order after the arrival time' do
    order
    worker_sign_in_as(worker)
    click_on "view_sections"
    click_on order.section.name
    click_on 'Orders'
    Timecop.freeze(Time.local(2014,1,4,13,59,00))
    click_on "completed_#{order.id}"

    expect(page).to_not have_content 'Arrival must be a future time'
    expect(page).to_not have_content 'Order changed successfully'
    expect(page).to_not have_content 'There was an error.'
    order = Order.first
    expect(order.status).to eql('completed')
  end
end
