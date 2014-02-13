require 'spec_helper'

feature 'user can delete their order' do
  let(:order) { create_order }
  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  scenario 'user can see their order' do
    order
    sign_in_as(order.user)
    click_on 'my_orders'

    expect(page).to have_content order.display_string
    expect(page).to have_content order.clean_arrival_time
  end

  scenario 'user deletes their order' do
    order
    sign_in_as(order.user)
    click_on "my_orders"
    expect(page).to have_content order.display_string
    expect(page).to have_content order.clean_arrival_time
    click_on 'Cancel Order'
    expect(page).to have_content 'Order cancelled'
    expect(page).to have_content 'Order Food'
    click_on 'my_orders'

    expect(page).to_not have_content order.display_string
    expect(page).to_not have_content order.clean_arrival_time
  end

  scenario 'users can only delete their own orders' do
    order
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)

    expect{ visit user_order_path(order.user, order) }.to raise_error
  end
end
