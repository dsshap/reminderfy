require 'spec_helper'

describe Provider do

  context 'provider creation' do

    it 'should require that the password and password confirmation match' do
      provider = Provider.new(fname: 'John', lname: 'Doe', email: 'jd@example.com', password: 'password', password_confirmation: 'password1', establishment_name: 'test office')

      provider.should_not be_valid
      provider.errors[:password].should include('doesn\'t match confirmation')
    end

    it 'should require establishment_name' do
      provider = FactoryGirl.create(:provider)
      provider[:establishment_name] = nil
      #provider = Provider.create(fname: 'John', lname: 'Doe', email: 'jd@example.com', password: 'password', password_confirmation: 'password')

      provider.should_not be_valid
      provider.errors[:establishment_name].should include('Establishment name is required')
    end

    it 'should create a provider' do
      provider = FactoryGirl.create(:provider)

      provider.should_not be_new_record
      provider.fname.should eq('John')
      provider.establishment_name.should eq('test office')
    end

    it 'should allow a name update without a password' do
      provider = FactoryGirl.create(:provider)

      provider.update_attribute(:fname, 'David')
      provider.fname.should eq('David')
    end

  end

  context 'client creation by provider' do

    it 'should create a client' do
      provider = FactoryGirl.create(:provider)
      c = provider.clients.new(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      c.save
      #client = provider.add_client(c)

      provider.clients.count.should eq(1)
      c.provider_id.should eq(provider.id)
    end

    it 'should require name for client' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.new(email: 'ja@example.com')

      client.should_not be_valid
      client.errors[:fname].should include('Client name must be entered')
    end

    it 'should require phone number for client' do
      provider = FactoryGirl.create(:provider)
      client = provider.clients.new(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com')

      client.should_not be_valid
      client.errors[:phone_number].should include('Phone number is required')
    end

    it 'should require unique phone number for client' do
      provider = FactoryGirl.create(:provider)
      client1 = provider.clients.create!(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')
      client2 = provider.clients.new(fname: 'Johnny', lname: 'Appleseed', email: 'ja@example.com', phone_number: '1234567890')

      client2.should_not be_valid
      client2.errors[:phone_number].should include('This phone number has already been taken')
    end

  end

end
