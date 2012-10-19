class ReminderSet

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :provider

  field :send_at,                 type: DateTime
  field :reminder_msg_tmpl,       type: String


  embeds_many :reminders, cascade_callbacks: true do
    def find_by_client(reminder)
      where(client_id: reminder.client_id).to_a
    end    
  end

  attr_accessible :send_at, :reminder_msg_tmpl
  accepts_nested_attributes_for :reminders

  validates_presence_of :send_at, message: 'A time to send this reminder is required.'
  validates_presence_of :reminder_msg_tmpl, message: "A message template is required."


end