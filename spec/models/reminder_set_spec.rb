require 'spec_helper'

describe ReminderSet do

  context 'reminder set creation' do

    it 'should create a reminder set' do
      provider = FactoryGirl.create(:provider)
      send_time = Time.now
      reminder_set = provider.reminder_sets.create! send_at: send_time, reminder_msg_tmpl: "Test Msg"

      provider.reminder_sets.first.reminder_msg_tmpl.should eq("Test Msg")
      provider.reminder_sets.first.id.should eq(reminder_set.id)

    end

  end

  context 'reminder creation' do

    it 'should not be a valid reminder' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.create!(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      reminder_set = provider.reminder_sets.create send_at: Time.now, reminder_msg_tmpl: "Test Msg"
      reminder = reminder_set.reminders.new

      reminder.should_not be_valid
      reminder.errors[:client_id].should include('can\'t be blank')
    end

    it 'should create a reminder in a reminder_set' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.create!(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      reminder_set = provider.reminder_sets.create! send_at: Time.now, reminder_msg_tmpl: "Test Msg"
      reminder = reminder_set.reminders.new client: client
      reminder.save

      provider.reminder_sets.first.reminders.first.client_id.should eql(client.id)
      provider.reminder_sets.first.reminders.count.should eql(1)
    end

    it 'should not add a client twice to a reminder set' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.create!(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      reminder_set = provider.reminder_sets.create! send_at: Time.now, reminder_msg_tmpl: "Test Msg"
      reminder_set.reminders.create client: client
      reminder = reminder_set.reminders.new client: client


      reminder.should_not be_valid
      reminder.errors[:client_id].should include('Client is already part of this reminder set')
      provider.reminder_sets.first.reminders.count.should eql(1)
    end

  end

end