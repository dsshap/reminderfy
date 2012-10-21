class CommunicationVehicle

  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  embedded_in :reminder

  field :provider
  field :message_id
  field :error_msg

  attr_accessible :provider, :message_id, :error_msg

  state_machine :status, :initial => :pending do
    event :success do
      transition :pending => :successful
    end
    event :failed do
      transition :pending => :failed
    end
  end

end

class Sms < CommunicationVehicle
  def initialize
    super
    self.provider = "twilio"
  end
end

class Phone < CommunicationVehicle
  def initialize
    super
    self.provider = "twilio"
  end
end

class Email < CommunicationVehicle
  def initialize
    super
    self.provider = "mandrill"
  end
end