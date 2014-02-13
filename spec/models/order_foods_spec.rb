require 'spec_helper'

describe OrderFood do
  it { should belong_to :order }
  it { should belong_to :food }
  it { should validate_presence_of :order }
  it { should validate_presence_of :food }
end
