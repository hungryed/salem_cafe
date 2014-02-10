require 'spec_helper'

feature 'worker only sees non completed orders' do
  let(:order) { FactoryGirl.create(:order) }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,7,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'worker sees uncompleted orders' do
    worker_sign_in_as(worker)
    order
    visit root_path
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.section.name
    expect(page).to have_content order.food.name
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order.clean_arrival_time
    click_on 'Completed'
    visit root_path
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.section.name
    expect(page).to_not have_content order.food.name
    expect(page).to_not have_content order.user.first_name
    expect(page).to_not have_content order.user.last_name
    expect(page).to_not have_content order.clean_arrival_time
  end

  scenario 'worker only sees today uncompleted orders' do
    worker_sign_in_as(worker)
    order
    visit root_path
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.section.name
    expect(page).to have_content order.food.name
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order.clean_arrival_time
    Timecop.return
    visit root_path
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.section.name
    expect(page).to_not have_content order.food.name
    expect(page).to_not have_content order.user.first_name
    expect(page).to_not have_content order.user.last_name
    expect(page).to_not have_content order.clean_arrival_time
  end

  scenario 'worker can set order to in progress' do
    worker_sign_in_as(worker)
    order
    visit root_path
    click_on "view_sections"
    click_on "section_#{order.section.id}"
    click_on 'Orders'
    expect(page).to have_content order.section.name
    expect(page).to have_content order.food.name
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order.clean_arrival_time
    click_on 'In Progress'
    expect(page).to have_content order.section.name
    expect(page).to have_content order.food.name
    expect(page).to have_content order.user.first_name
    expect(page).to have_content order.user.last_name
    expect(page).to have_content order.clean_arrival_time
  end
end
