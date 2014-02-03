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

  it "builds a users full name" do
    user = FactoryGirl.create(:user, first_name: 'Mike',
      last_name: 'Smith')
    expect(user.full_name).to eql('Mike Smith')
  end

  it "only allows users to be one of three roles" do
    user = FactoryGirl.create(:user)
    user.role = 'customer'
    expect(user).to be_valid
    user.role = 'worker'
    expect(user).to be_valid
    user.role = 'admin'
    expect(user).to be_valid
    user.role = 'taco'
    expect(user).to_not be_valid
  end
  it { should have_valid(:phone_number).when('4134469666', nil, '(413)-446-9644') }
  it { should_not have_valid(:phone_number).when('41344696666', 'abcd12') }

end
