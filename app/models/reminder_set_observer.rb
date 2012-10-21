class ReminderSetObserver < Mongoid::Observer

  def after_start(reminder_set, transition)
    reminder_set.reminders.collect(&:start)
    reminder_set.wrap_up_reminders
    # log message
  end

end