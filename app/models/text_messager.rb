class TextMessager
  ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  ACCOUNT_NUMBER = ENV['TWILIO_ACCOUNT_NUMBER']

  def self.send_text(user)
    if user.accepts_texts?
      user_number = user.phone_number
      begin
        client.account.sms.messages.create(
          from: twilio_number(ACCOUNT_NUMBER),
          to: twilio_number(user_number),
          body: 'Your order is in progress. Please be ready to come pick it up'
        )
        true
      rescue Twilio::REST::RequestError
        false
      end
    else
      nil
    end
  end

  private
  def self.twilio_number(number)
    "+1#{number}"
  end

  def self.client
    Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end
end
