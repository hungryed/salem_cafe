require 'spec_helper'

describe TextMessager do
  before :each do
    SmsSpec::Data.clear_messages
  end

  it "sends a text to the user's number" do
    user = FactoryGirl.create(:user, phone_number: '6105557069')
    message = 'Your order is in progress. Please be ready to come pick it up'

    text = TextMessager.send_text(user)
    open_last_text_message_for(user.phone_number)

    expect(current_text_message.body).to eq message
  end
end
