require 'spec_helper'

feature 'user places an order' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:food) { FactoryGirl.create(:food) }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  context "authenticated user" do
    scenario 'authenticated user places an order' do
      sign_in_as(user)
      click_on 'Order Food'
      select food.name, from: 'Food'
      within '#order_arrival_time_4i' do
        select '11'
      end
      within '#order_arrival_time_5i' do
        select '10'
      end
      click_on 'Create Order'

      expect(page).to have_content 'Order placed successfully'
      expect(page).to have_content 'Order Food'
      expect(page).to have_content 'Sign Out'
    end

    scenario "authenticated user supplies bad information" do
      Timecop.freeze(Time.local(2014,1,4,13,0,0))
      sign_in_as(user)
      click_on 'Order Food'
      select food.name, from: 'Food'
      within '#order_arrival_time_4i' do
        select '11'
      end
      within '#order_arrival_time_5i' do
        select '10'
      end
      click_on 'Create Order'

      expect(page).to have_content 'Arrival must be a future time'
      expect(page).to_not have_content 'Order Food'
    end

  end


  scenario "unauthenticated user can't place an order" do
    visit root_path
    click_on 'Order Food'
    expect(page).to have_content 'You do not have permission to access that page'
    expect(page).to have_content 'Sign Up'
  end

end
