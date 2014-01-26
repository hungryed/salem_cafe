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
  context "Verified admin" do
    scenario 'sees orders' do
      admin_sign_in_as(admin)
      visit root_path
      order
      click_on "see_order_totals"
      expect(page).to have_content order.food.name
      expect(page).to have_content order.clean_arrival_time
      expect(page).to have_content order.section.name
    end

    scenario "sees orders for only today on Today's Orders" do
      admin_sign_in_as(admin)
      visit root_path
      order
      click_on "see_order_totals"
      expect(page).to have_content order.food.name
      expect(page).to have_content order.clean_arrival_time
      expect(page).to have_content order.section.name
      Timecop.return
      visit order_totals_path
      expect(page).to_not have_content order.food.name
      expect(page).to_not have_content order.clean_arrival_time
      expect(page).to_not have_content order.section.name
    end

    scenario "sees orders over a range of dates" do
      admin_sign_in_as(admin)
      visit root_path
      order
      click_on "see_order_totals"
      fill_in "start_date", with: "2 January, 2014"
      fill_in "end_date", with: "10 January, 2014"
      click_on "Find Orders in Range"
      expect(page).to have_content order.food.name
      expect(page).to have_content order.clean_arrival_time
      expect(page).to have_content order.section.name
      fill_in "start_date", with: "2 January, 2014"
      fill_in "end_date", with: "3 January, 2014"
      click_on "Find Orders in Range"
      expect(page).to_not have_content order.food.name
      expect(page).to_not have_content order.clean_arrival_time
      expect(page).to_not have_content order.section.name
    end
  end

  context "Unverified admin" do
    scenario "worker can't see total orders" do
      worker_sign_in_as(worker)
      visit root_path
      expect(page).to_not have_content "See Order Totals"
      visit order_totals_path
      expect(page).to have_content 'You do not have permission to access that page'
    end

    scenario "user can't see total orders" do
      sign_in_as(user)
      visit root_path
      expect(page).to_not have_content "See Order Totals"
      visit order_totals_path
      expect(page).to have_content 'You do not have permission to access that page'
    end

    scenario "unauthenticated users can't see total orders" do
      visit root_path
      expect(page).to_not have_content "See Order Totals"
      visit order_totals_path
      expect(page).to have_content 'You do not have permission to access that page'
    end
  end
end
