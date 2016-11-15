class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :email, type: String
  field :fName, type: String, as: 'first_name'
  field :lName, type: String, as: 'last_name'
  field :password_digest, type: String
  field :contact, type: String
  field :status, type: String, default: 'P'
  field :role, type: String, default: 'U'

  has_secure_password

  has_many :bookings
  has_many  :notes
end
