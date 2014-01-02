require 'spec_helper'

describe User do
  it { should validate_presence_of :first_name }
  it { should have_valid(:first_name).when('John', 'Sailor') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should validate_presence_of :last_name }
  it { should have_valid(:last_name).when('Smith', 'Moon') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should validate_presence_of :email }
  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when('user@example',
    'another@com', nil, '', 'smith.com', 'fourty') }

end
