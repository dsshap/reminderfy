class Person
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :fname,             type: String, default: ""
  field :lname,             type: String, default: ""
  field :email,             type: String
  field :phone_number,      type: String

  attr_accessible :fname, :lname, :email, :phone_number

  def name
    "#{fname} #{lname}"
  end

end