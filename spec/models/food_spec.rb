require 'spec_helper'

describe Food do
  let(:blanks) { [nil, ''] }

  it { should validate_presence_of :name }
  it { should have_valid(:name).when('Chicken Sandwich', 'Pickle') }
  it { should_not have_valid(:name).when(*blanks) }

  it { should have_valid(:description).when('it has chicken', 'green') }
  it { should have_valid(:description).when(*blanks) }

end
