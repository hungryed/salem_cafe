require 'spec_helper'

describe Section do
  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Deli', 'Hot Line', 'Grill') }
  it { should_not have_valid(:name).when(nil, '') }
  it { should validate_uniqueness_of :name }

  it { should have_many(:food_categories) }
  it { should have_many :orders }
  it { should have_many :foods }

  it { should validate_presence_of :start_time }
  it { should have_valid(:start_time).when('11:00','7:00','12:00') }
  it { should_not have_valid(:start_time).when(nil,'','0:00','6:00','15:00') }

  it { should validate_presence_of :end_time }
  it { should have_valid(:end_time).when('11:00','10:00','12:00') }
  it { should_not have_valid(:end_time).when(nil,'','0:00','6:00','15:00') }

  it "should validate start_time is before end_time" do
    section = Section.new(name: 'Hot Line', start_time: '11:00', end_time: '10:00')
    expect(section).to_not be_valid
  end

  it "should group foods by food category" do
    food = FactoryGirl.create(:food)
    grouped_foods = food.section.grouped_foods
    foods_hash = {food.food_category => [food]}
    expect(grouped_foods).to eql(foods_hash)
  end
end
