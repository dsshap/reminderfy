class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :fname,             type: String, default: ""
  field :lname,             type: String, default: ""
  field :email,             type: String, default: ""
  field :phone_number,      type: String, default: ""

  attr_accessible :fname, :lname, :email, :phone_number

end