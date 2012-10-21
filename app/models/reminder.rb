class Reminder

  include Mongoid::Document
  include Mongoid::Timestamps::Created

  embedded_in :reminder_set

  field :client_id,     type: Moped::BSON::ObjectId

  embeds_many :communication_vehicles, cascade_callbacks: true do
    def sms_messages
      where(_type: "Sms")
    end
    def phone_calls
      where(_type: "Phone")
    end
    def emails
      where(_type: "Email")
    end
  end

  attr_accessible :client_id, :client
  accepts_nested_attributes_for :communication_vehicles

  validates_presence_of :client_id
  validates_uniqueness_of :client_id, message: "Client is already part of this reminder set"

  before_create :create_communication_vehicles

  state_machine :status, :initial => :pending do
    event :start do
      transition :pending => :started
    end
    event :completed do
      transition :started => :completed
    end
    event :failed do
      transition :started => :failed
    end
    event :cancel do
      transition :pending => :canceled
    end
  end

  def send_communications
    communication_vehicles.each do |com_vehicle|
      unless ENV["RAILS_ENV"] == 'test'
        #TODO implement sending
      end
      com_vehicle.success
    end
  end

  def wrap_up
    statuses = communication_vehicles.collect(&:status)
    unless statuses.include?("failed")
      completed
    else
      failed
    end
  end

  def create_communication_vehicles
    unless client.phone_number.blank?
      communication_vehicles.push(Sms.new)
      communication_vehicles.push(Phone.new)
    end
    unless client.email.blank?
      communication_vehicles.push(Email.new)
    end
  end

  def client=(client)
    if client.class.name.eql?('Client')
      self.client_id = client.id
    else
      errors.add(:client_id, "Object passed in is not of type Client")
    end
  end

  def client
    @client ||= Client.find(client_id) rescue nil
  end

end