require 'spec_helper'

describe Order do
  it { should belong_to :user }
  it { should belong_to :food }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil, '') }

  it { should have_valid(:arrival_time).when('11:40', '14:00', '11:00', '12:00', '13:23') }
  it { should_not have_valid(:arrival_time).when(nil, '','6:59', '14:01', '0:00')}
end
