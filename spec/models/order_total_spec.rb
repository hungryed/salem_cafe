require 'spec_helper'

describe OrderTotal do
  let(:order) { FactoryGirl.create(:order) }

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  it "finds orders on object creation with no dates" do
    order
    orders = OrderTotal.new
    orders = orders.find_orders_in_range
    expect(orders).to include(order)
  end

  it "finds orders within a range" do
    order
    orders = OrderTotal.new('2014-1-3', '2014-1-10')
    orders = orders.find_orders_in_range
    expect(orders).to include(order)
  end

  it "does not find orders when they are not in range" do
    order
    orders = OrderTotal.new('2014-1-1', '2014-1-3')
    orders = orders.find_orders_in_range
    expect(orders).to_not include(order)
  end

  it "finds all orders for today" do
    order
    orders = OrderTotal.todays_orders
    expect(orders.find_orders_in_range).to include(order)
    Timecop.return
    orders = OrderTotal.todays_orders
    expect(orders.find_orders_in_range).to_not include(order)
  end
end
