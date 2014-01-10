require 'spec_helper'

describe Section do
  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Deli', 'Hot Line', 'Grill') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_many(:foods).through(:food_categories) }
  it { should have_many(:food_categories) }
  it { should have_many :orders }
end
