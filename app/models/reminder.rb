class Reminder

  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :reminder_set

end