require 'spec_helper'

feature 'workers can see orders for their sections' do
  let(:order) { create_order }
  let(:user) { FactoryGirl.create(:user) }
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
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.section.name
    expect(page).to have_content order.display_string
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order.clean_arrival_time
  end

  scenario 'authenticated worker sees specific order' do
    worker_sign_in_as(worker)
    order
    order2 = create_order(section: order.section,
        arrival_time: '12:30')
    order.section.save
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.display_string
    expect(page).to have_content order2.display_string
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order2.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order2.user.last_name
    expect(page).to have_content order.clean_arrival_time
    expect(page).to have_content order2.clean_arrival_time
    click_on order.clean_arrival_time
    expect(page).to have_content order.display_string
    expect(page).to_not have_content order2.display_string
    expect(page).to have_content order.user.first_name
    expect(page).to_not have_content order2.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to_not have_content order2.user.last_name
    expect(page).to have_content order.clean_arrival_time
    expect(page).to_not have_content order2.clean_arrival_time
  end

  scenario 'authenticated worker only sees todays orders' do
    worker_sign_in_as(worker)
    order.section.save
    visit "/sections/#{order.section.id}/orders"
    expect(page).to have_content order.display_string
    visit root_path
    Timecop.freeze(Time.local(2014,1,10,6,0,0))
    visit "/sections/#{order.section.id}/orders"
    expect(page).to have_content order.section.name
    expect(page).to_not have_content order.display_string
    expect(page).to_not have_content order.user.first_name
    expect(page).to_not have_content order.user.last_name
    expect(page).to_not have_content order.clean_arrival_time
  end

  scenario "non-worker can't visit section to see orders" do
    sign_in_as(order.user)
    order.section.save
    visit root_path
    expect(page).to_not have_content 'See Orders'
    visit "/sections/#{order.section.id}/orders"

    expect(page).to_not have_content order.user.first_name
    expect(page).to_not have_content order.user.last_name
  end
end
