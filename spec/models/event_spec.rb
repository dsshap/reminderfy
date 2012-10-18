require 'spec_helper'

describe Event do

  it 'should record an Event of varying parts' do
    provider = Provider.create(fname: 'John', lname: 'Doe', email: 'jd@example.com', password: 'password', password_confirmation: 'password', establishment_name: 'test office')
    client = provider.clients.create(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')

    event = Evently.record(provider, 'added', client, 'as a client')

    event.should have(4).event_parts
    event.event_parts.first.content.should eq({
      name: 'John Doe',
      class_name: 'Provider',
      id: provider.id.to_s
    })
    event.event_parts.last.content.should eq('as a client')
  end

  it 'should fetch events for some object' do
    provider = Provider.create(fname: 'John', lname: 'Doe', email: 'jd@example.com', password: 'password', password_confirmation: 'password', establishment_name: 'test office')
    client = provider.clients.create(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')

    Evently.record(provider, 'signed up')
    Evently.record(provider, 'added', client)
    events = Evently.fetch(provider)

    events.size.should eq(2)
  end
end

describe EventPart do

  it 'should serialize and initialize an EventPart from a user' do
    provider = Provider.create(fname: 'John', lname: 'Doe', email: 'jd@example.com', password: 'password', password_confirmation: 'password', establishment_name: 'test office')
    event_part = EventPart.serialize_and_initialize(provider)
    event_part.content.should eq({
      name: 'John Doe',
      class_name: 'Provider',
      id: provider.id.to_s
    })
  end
end