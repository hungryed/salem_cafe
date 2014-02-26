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
      food = FactoryGirl.create(:food,
        food_category: food_category,
        section: section)
      food_category2 = FactoryGirl.create(:food_category, section: section)
      food2 = FactoryGirl.create(:food,
        food_category: food_category2,
        section: section)
      sign_in_as(user)
      click_on "order_food"
      click_on section.name
      select food.name, from: "#{food_category.name}", match: :prefer_exact
      select food2.name, from: "section_#{section.id}_category_#{food_category2.id}", match: :prefer_exact
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

    scenario 'authenticated user places an order with multiple from the same category' do
      food_category = FactoryGirl.create(:food_category,
        section: section,
        multiple: true)
      food = FactoryGirl.create(:food,
        food_category: food_category,
        section: section)
      food2 = FactoryGirl.create(:food,
        food_category: food_category,
        section: section
        )
      sign_in_as(user)
      click_on "order_food"
      click_on section.name
      choose food.name
      choose food2.name
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
      Timecop.travel(Time.local(2014,1,4,13,59,59))
      food_category = FactoryGirl.create(:food_category, section: section)
      food = FactoryGirl.create(:food,
        food_category: food_category,
        section: section)
      sign_in_as(user)
      click_on "order_food"
      click_on section.name
      select food.name, from: food_category.name
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
end
