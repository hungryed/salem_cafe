require 'spec_helper'

feature 'user places an order' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:section) { FactoryGirl.create(:section) }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  context "authenticated user" do
    scenario 'authenticated user places an order' do
      food_category = FactoryGirl.create(:food_category, section: section)
      food = FactoryGirl.create(:food, food_category: food_category)
      sign_in_as(user)
      click_on "order_food"
      click_on section.name
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
      food_category = FactoryGirl.create(:food_category, section: section)
      food = FactoryGirl.create(:food, food_category: food_category)
      sign_in_as(user)
      click_on "order_food"
      click_on section.name
      select food.name, from: 'Food'
      within '#order_arrival_time_4i' do
        select '11 AM'
      end
      within '#order_arrival_time_5i' do
        select '00'
      end
      click_on 'Create Order'

      expect(page).to have_content 'Arrival must be a future time'
    end
  end

  scenario "unauthenticated user can't place an order" do
    visit root_path
    click_on "order_food"
    expect(page).to have_content 'Sign Up'
  end

  scenario 'user can edit their order' do
    food_category = FactoryGirl.create(:food_category, section: section)
    food = FactoryGirl.create(:food, food_category: food_category)
    order = FactoryGirl.create(:order, section: section, food: food)
    user = order.user
    sign_in_as(user)
    visit root_path
    click_on "my_orders"
    expect(page).to have_content order.food.name
    click_on 'Edit Order'
    within '#order_arrival_time_4i' do
      select '1 PM'
    end
    click_on 'Update Order'

    expect(page).to have_content 'Order changed successfully'

  end

  scenario 'user edits their order with bad info' do
    food_category = FactoryGirl.create(:food_category, section: section)
    food = FactoryGirl.create(:food, food_category: food_category)
    order = FactoryGirl.create(:order, section: section, food: food)
    user = order.user
    sign_in_as(user)
    visit root_path
    click_on "my_orders"
    expect(page).to have_content order.food.name
    Timecop.freeze(2014,1,4,12,0,0)
    click_on 'Edit Order'
    select '', from: 'Food'
    within '#order_arrival_time_4i' do
      select '11 AM'
    end
    click_button 'Update Order'

    expect(page).to have_content 'Arrival must be a future time'
    expect(page).to have_content "can't be blank"
  end
end
