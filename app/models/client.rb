class Client < Person
  belongs_to :provider
  validates_uniqueness_of :phone_number, message: "This phone number has already been taken"
  validates_presence_of :phone_number, message: "Phone number is required"
  validate :name_exists

  after_create :log_create_event

  def name_exists
    name = "#{fname} #{lname}"
    if name.strip.empty?
      errors.add(:fname, "Client name must be entered")
    end
    self
  end

  def log_create_event
    Evently.record(self.provider, 'added', self)
  end


end