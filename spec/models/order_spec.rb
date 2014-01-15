require 'spec_helper'

describe Order do
  let(:blanks) {[nil, '']}

  before(:each) do
    Timecop.freeze(Time.local(2014,1,4,6,0,0))
  end

  after(:each) do
    Timecop.return
  end

  it { should belong_to :user }
  it { should belong_to :food }
  it { should validate_presence_of :section }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:food).when(Food.new) }
  it { should_not have_valid(:food).when(nil)}

  it { should have_valid(:arrival_time).when('11:40', '14:00', '11:00', '12:00', '13:23') }
  it { should_not have_valid(:arrival_time).when(*blanks,'6:59', '14:01', '0:00')}

  it { should respond_to(:clean_arrival_time) }
  it "should remove timestamps, year and seconds from arrival time" do
    order = FactoryGirl.create(:order)
    expect(order.clean_arrival_time).to eql('01-04 01:55PM')
  end
end
