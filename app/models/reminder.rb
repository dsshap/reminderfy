class Reminder

  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :reminder_set

  field :client_id,     type: Moped::BSON::ObjectId

  attr_accessible :client_id, :client

  validates_presence_of :client_id
  validates_uniqueness_of :client_id, message: "Client is already part of this reminder set"


  def client=(client)
    if client.class.name.eql?('Client')
      self.client_id = client.id
    else
      errors.add(:client_id, "Object passed in is not of type Client")
    end
  end

  def client
    Client.find(client_id) rescue nil
  end

end