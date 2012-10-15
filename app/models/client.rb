class Client < Person
  belongs_to :provider
  validates_uniqueness_of :phone_number, message: "This phone number has already been taken."
end