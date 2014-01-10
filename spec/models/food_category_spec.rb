require 'spec_helper'

describe FoodCategory do
  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Side', 'Entree', 'Bread') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_many :foods }
  it { should validate_presence_of :section }
  it { should belong_to :section }
end
