require 'spec_helper'

describe Food do
  let(:blanks) { [nil, ''] }

  it { should have_many :orders }
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
  it { should_not belong_to(:section) }
  it "should associate a section through food_category" do
    food_category = FactoryGirl.create(:food_category)
    food = FactoryGirl.create(:food, food_category: food_category)
    expect(food.section).to eq(food_category.section)
  end

  it "should associate a section id through food_category" do
    food_category = FactoryGirl.create(:food_category)
    food = FactoryGirl.create(:food, food_category: food_category)
    expect(food.section_id).to eq(food_category.section.id)
  end

  it { should validate_presence_of :food_category }

  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Chicken Sandwich', 'Pickle') }
  it { should_not have_valid(:name).when(*blanks) }

  it { should have_valid(:description).when('it has chicken', 'green') }
  it { should have_valid(:description).when(*blanks) }

  it { should respond_to(:picture_url) }
  it { should have_valid(:price).when('4.44', '0.00') }
  it { should_not have_valid(:price).when('1.111', '71.999', '71.', '-91.00','taco') }
end
