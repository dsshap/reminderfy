require 'spec_helper'

describe ReminderSet do

  context 'reminder set creation' do

    it 'should create a reminder' do
      provider = Provider.create(fname: 'John', lname: 'Doe', email: 'jd@example.com', password: 'password', password_confirmation: 'password', establishment_name: 'test office')
      send_time = Time.now
      reminder_set = provider.reminder_sets.create send_at: send_time, reminder_msg_tmpl: "Test Msg"

      provider.reminder_sets.first.send_at.should eq(send_time)
      provider.reminder_sets.first.reminder_sets.should eq("Test Msg")
      provider.reminder_sets.first.id.should eq(reminder_set.id.to_s)

    end

  end

end