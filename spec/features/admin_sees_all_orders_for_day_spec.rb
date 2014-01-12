require 'spec_helper'

feature 'admin sees all orders for day' do
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let(:worker) { FactoryGirl.create(:user, role: 'worker') }
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order) }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'verified admin sees orders' do
    admin_sign_in_as(admin)
    visit root_path
    order
    click_on "See Order Totals"
    expect(page).to have_content "Today's Orders"
    expect(page).to have_content order.section.name
  end

  scenario "worker can't see total orders"

  scenario "user can't see total orders"

  scenario "unauthenticated users can't see total orders"
end
