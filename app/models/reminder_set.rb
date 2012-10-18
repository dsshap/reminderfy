class ReminderSet

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :provider

  field :send_at,                 type: TimeWithZone
  field :reminder_msg_tmpl,       type: String


  embeds_many :reminders, cascade_callbacks: true

  attr_accessible :send_at, :reminder_msg_tmpl

  validates_presence_of :send_at, message: 'A time to send this reminder is required.'
  validates_presence_of :reminder_msg_tmpl, message: "A message template is required."


end