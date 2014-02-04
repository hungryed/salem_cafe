require 'spec_helper'

feature 'worker sends a text with order progress button' do
  context 'customer with a phone number' do
    let(:order) { FactoryGirl.create(:order) }

    before :each do
      Timecop.freeze(Time.local(2014,1,4,7,0,0))
      SmsSpec::Data.clear_messages
    end

    after :each do
      Timecop.return
    end

    scenario 'customer accepting texts' do
      order
      worker = FactoryGirl.create(:user, role: 'worker')
      worker_sign_in_as(worker)
      visit root_path
      click_on 'view_sections'
      click_on order.section.name
      click_on 'Orders'
      click_on 'In Progress'

      open_last_text_message_for("+1#{order.user.phone_number}")
      expect(current_text_message.body).to eql('Your order is in progress. Please be ready to come pick it up')
    end

    scenario 'customer not accepting texts' do
      order
      order.user.receives_texts = false
      order.user.save
      worker = FactoryGirl.create(:user, role: 'worker')
      worker_sign_in_as(worker)
      visit root_path
      click_on 'view_sections'
      click_on order.section.name
      click_on 'Orders'
      click_on 'In Progress'

      open_last_text_message_for("+1#{order.user.phone_number}")
      expect(current_text_message).to be_nil
    end
  end
end
