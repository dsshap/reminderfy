class Provider < Person
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :validatable,
         :recoverable, :rememberable, :trackable

  ## Database authenticatable
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  #TODO
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  field :establishment_name

  has_many :clients, autosave: true
  has_many :reminder_sets, autosave: true

  attr_accessible :password, :password_confirmation, :remember_me, :establishment_name, :clients_attributes, :reminder_sets_attributes
  accepts_nested_attributes_for :clients, :allow_destroy => true

  validates_presence_of :establishment_name, message: "Establishment name is required."

end
