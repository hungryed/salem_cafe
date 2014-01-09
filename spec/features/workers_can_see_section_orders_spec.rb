require 'spec_helper'

feature 'workers can see orders for their sections' do
  let(:order) { FactoryGirl.create(:order) }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'authenticated worker visits section' do
    worker_sign_in_as(worker)
    order.section.save
    visit root_path
    click_on 'See Orders'
    expect(page).to have_content 'Orders'
    visit "/sections/#{order.section.id}/orders"
    expect(page).to have_content order.section.name
    expect(page).to have_content order.food.name
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order.arrival_time
  end

  scenario 'authenticated worker only sees todays orders'

  scenario "non-worker can't visit section to see orders"
end
