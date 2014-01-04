require 'spec_helper'

describe User do
  let(:blanks) {[nil, '']}

  it { should have_many :orders }
  it { should validate_presence_of :first_name }
  it { should have_valid(:first_name).when('John', 'Sailor') }
  it { should_not have_valid(:first_name).when(*blanks) }

  it { should validate_presence_of :last_name }
  it { should have_valid(:last_name).when('Smith', 'Moon') }
  it { should_not have_valid(:last_name).when(*blanks) }

  it { should validate_presence_of :email }
  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when('user@example',
    'another@com', *blanks, 'smith.com', 'fourty') }

end
