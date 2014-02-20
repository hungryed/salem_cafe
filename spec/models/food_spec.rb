require 'spec_helper'

describe Food do
  let(:blanks) { [nil, ''] }
  it { should have_many :order_foods }
  it { should have_many(:orders).through(:order_foods) }
  it { should belong_to :food_category }
  it "should validate uniqueness of food name scoped to food_category" do
    food_category = FactoryGirl.create(:food_category)
    food = FactoryGirl.create(:food, food_category: food_category)
    food2 = FactoryGirl.build(:food,
     food_category: food_category,
     name: food.name)

    expect(food2).to_not be_valid
  end
  it { should respond_to(:section) }

  it { should validate_presence_of :food_category }

  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Chicken Sandwich', 'Pickle') }
  it { should_not have_valid(:name).when(*blanks) }

  it { should have_valid(:description).when('it has chicken', 'green') }
  it { should have_valid(:description).when(*blanks) }

  it { should respond_to(:picture_url) }

  it { should have_valid(:price).when('4.44', '0.00') }
  it { should_not have_valid(:price).when('1.111', '71.999', '71.', '-91.00','taco') }

  it { should belong_to :section }

  it "has a method to show if it is on the menu" do
    food = FactoryGirl.create(:food)
    expect(food.on_menu).to be_true
  end
end
