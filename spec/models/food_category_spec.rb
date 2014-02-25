require 'spec_helper'

describe FoodCategory do
  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Side', 'Entree', 'Bread') }
  it { should_not have_valid(:name).when('', nil) }
  it "should only allow a food category name to be created only one time" do
    food_category = FactoryGirl.create(:food_category)
    food_category2 = FactoryGirl.build(:food_category,
      section: food_category.section,
      name: food_category.name)
    expect(food_category2).to_not be_valid
  end

  it { should have_many :foods }
  it { should validate_presence_of :section }
  it { should belong_to :section }
  describe "should allow customers to have multiple" do
    it { should respond_to :multiple }
    it "allows it to be set to multiple" do
      food_category = FactoryGirl.create(:food_category)
      food_category.multiple = true
      expect(food_category.save).to be_true
    end
  end
end
