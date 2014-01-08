require 'spec_helper'

feature 'user submits a contact form' do
  before(:each) do
    ActionMailer::Base.deliveries = []
  end
  let(:user) { FactoryGirl.create(:user) }
  scenario 'user supplies valid information' do
    visit root_path
    click_on 'Contact Us'
    fill_in 'Email', with: user.email
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Subject', with: 'A valid Complaint'
    fill_in 'Description', with: 'I hate the universe'
    click_on 'Submit Contact'

    expect(page).to have_content 'Your form has been submitted'
    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('A valid Complaint')
    expect(last_email).to deliver_to('hungryed6@yahoo.com')
    expect(last_email).to have_body_text 'I hate the universe'
    expect(last_email).to deliver_from user.email
    expect(last_email).to have_body_text user.first_name
    expect(last_email).to have_body_text user.last_name
  end

  scenario 'user supplies invalid information' do
    visit new_contact_path
    click_on 'Submit Contact'

    expect_presence_error_for('contact', :email)
    expect_presence_error_for('contact', :first_name)
    expect_presence_error_for('contact', :last_name)
    expect_presence_error_for('contact', :subject)
    expect_presence_error_for('contact', :description)
    expect(ActionMailer::Base.deliveries.size).to eql(0)
  end

end
