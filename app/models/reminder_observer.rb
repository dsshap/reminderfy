class ReminderObserver < Mongoid::Observer

  def after_start(reminder, transition)
    reminder.send_communications
    reminder.wrap_up()
  end
  
end