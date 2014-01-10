require 'spec_helper'

describe Section do
  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Deli', 'Hot Line', 'Grill') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should respond_to :foods }
  it "should show all foods" do
    section = FactoryGirl.create(:section)
    food_category = FactoryGirl.create(:food_category, section: section)
    food = FactoryGirl.create(:food, food_category: food_category)

    expect(section.foods.first).to eq(food)
  end
  it { should have_many(:food_categories) }
  it { should have_many :orders }
end
