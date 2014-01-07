require 'spec_helper'

describe Contact do
  let(:blanks) { [nil, ''] }
  it { should validate_presence_of :email }
  it { should have_valid(:email).when('user@example.com', 'example@aol.com')}
  it { should_not have_valid(:email).when(*blanks, 'user', '@user.com',
      'user@user','user.com')}

  it { should validate_presence_of :first_name }
  it { should have_valid(:first_name).when('John', 'Bo') }
  it { should_not have_valid(:first_name).when(*blanks) }

  it { should validate_presence_of :last_name }
  it { should have_valid(:last_name).when('Smith', 'Jackson') }
  it { should_not have_valid(:last_name).when(*blanks) }

  it { should validate_presence_of :subject }
  it { should have_valid(:subject).when('this', 'A complaint') }
  it { should_not have_valid(:subject).when(*blanks,
    'This is a very long string that is going to be more than 255 characters.
    I do not know what it is going to convey but it is a test so therefore it
    does not matter. I am the king and it shall obey my command to fail this test.
    The first time I test it, it will fail. The next time it shall pass.') }

  it { should validate_presence_of :description }
  it { should have_valid(:description).when('this', 'A complaint', 'This is a very long string that is going to be more than 255 characters.
    I do not know what it is going to convey but it is a test so therefore it
    does not matter. I am the king and it shall obey my command to fail this test.
    The first time I test it, it will fail. The next time it shall pass.'
  ) }
  it { should_not have_valid(:description).when(*blanks) }

end
