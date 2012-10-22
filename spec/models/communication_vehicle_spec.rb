require 'spec_helper'

describe CommunicationVehicle do

  context 'communication creation' do

    it 'should not create vehicles' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.create!(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      reminder_set = provider.reminder_sets.create! send_at: Time.now, reminder_msg_tmpl: "Test Msg"
      reminder = reminder_set.reminders.new client: client, appointment_time: Time.now

      reminder.communication_vehicles.count.should eql(0)
    end

    it 'should create vehicles' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.create!(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      reminder_set = provider.reminder_sets.create! send_at: Time.now, reminder_msg_tmpl: "Test Msg"
      reminder = reminder_set.reminders.create client: client, appointment_time: Time.now

      reminder.communication_vehicles.count.should eql(3)
      reminder.communication_vehicles.sms_messages.count.should eql(1)
      reminder.communication_vehicles.sms_messages.first.provider.should eql("twilio")
      reminder.communication_vehicles.phone_calls.count.should eql(1)
      reminder.communication_vehicles.phone_calls.first.provider.should eql("twilio")
      reminder.communication_vehicles.emails.count.should eql(1)
      reminder.communication_vehicles.emails.first.provider.should eql("mandrill")
    end    

  end

end