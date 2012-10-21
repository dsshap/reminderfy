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

  state_machine :status, :initial => :pending do
    event :start do
      transition :pending => :started
    end
    event :completed do
      transition :started => :completed
    end
    event :completed_with_errors do
      transition :started => :completed_with_errors
    end
    event :cancel do
      transition :pending => :canceled
    end
  end

  after_create :log_created_event

  def wrap_up_reminders
    statuses = reminders.collect(&:status)
    unless statuses.include?("failed")
      completed
    else
      completed_with_errors
    end
  end

  def log_created_event
    Evently.record(self.provider, 'created', self)
  end

  def name
    "Reminder Set"
  end

end
