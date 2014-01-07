class ContactForm < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_form.receipt.subject
  #
  def receipt(contact_form)
    @contact_form = contact_form

    @greeting = "Hey baby"
    mail to: "hungryed6@yahoo.com",
      from: @contact_form.email,
      subject: 'Hey Sexy'
  end
end
