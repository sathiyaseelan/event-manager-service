class User

  include Mongoid::Document
  include Mongoid::Timestamps
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
  has_many :notes

  has_many :created_courses, class_name: "Course", inverse_of: :created_by

  has_and_belongs_to_many :enrolled_courses, class_name: "Course", inverse_of: :enrolled_users

  has_many :created_activities, class_name: "Activity", inverse_of: :created_by

  has_and_belongs_to_many :enrolled_activities, class_name: "Activity", inverse_of: :enrolled_users

  def is_super_user?
    role == 'SU'
  end

  def all_emails

  end


end
