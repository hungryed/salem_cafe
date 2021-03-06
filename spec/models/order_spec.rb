require 'spec_helper'

describe Order do
  let(:blanks) {[nil, '']}

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  it { should belong_to :user }
  it { should have_many :order_foods }
  it { should have_many(:foods).through(:order_foods) }
  it { should validate_presence_of :section }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:arrival_time).when('11:40', '14:00', '11:00', '12:00', '13:23') }
  it { should_not have_valid(:arrival_time).when(*blanks,'6:59', '14:01', '0:00')}

  it { should respond_to(:clean_arrival_time) }
  it "should remove timestamps, year and seconds from arrival time" do
    order = FactoryGirl.create(:order)
    expect(order.clean_arrival_time).to eql('01-04 01:55PM')
  end

  it "should check if an order is not completed" do
    order = FactoryGirl.create(:order)

    expect(order.completed?).to be_false
    order.status = 'completed'
    expect(order.completed?).to be_true
  end

  it "should only allow for order status to be in 3 formats" do
    order = FactoryGirl.create(:order)
    order.status = 'completed'
    expect(order).to be_valid
    order.status = 'in progress'
    expect(order).to be_valid
    order.status = 'not started'
    expect(order).to be_valid
    order.status = 'random string'
    expect(order).to_not be_valid
  end

  it "should should join together all items of an order in a string" do
    section = FactoryGirl.create(:section)
    food_category1 = FactoryGirl.create(:food_category,
     section: section)
    food_category2 = FactoryGirl.create(:food_category,
     section: section)
    food1 = FactoryGirl.create(:food,
      food_category: food_category1,
      section: section)
    food2 = FactoryGirl.create(:food,
      food_category: food_category2,
      section: section)
    order = FactoryGirl.create(:order)
    FactoryGirl.create(:order_food,
      order: order,
      food: food1)
    FactoryGirl.create(:order_food,
      order: order,
      food: food2)
    expect(order.display_string).to eql("#{food1.name} with #{food2.name}")

  end
end
