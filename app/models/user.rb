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

  has_many :bookings, inverse_of: :created_by
  has_many :notes

  has_many :created_courses, class_name: "Course", inverse_of: :created_by

  has_and_belongs_to_many :enrolled_courses, class_name: "Course", inverse_of: :enrolled_users

  has_many :created_activities, class_name: "Activity", inverse_of: :created_by

  has_and_belongs_to_many :enrolled_activities, class_name: "Activity", inverse_of: :enrolled_users

  #has_many :access_requests, inverse_of: :created_by
  has_many :approved_requests,class_name: "AccessRequest", inverse_of: :approved_by
  has_many :rejected_requests,class_name: "AccessRequest", inverse_of: :rejected_by

  has_many :outbox_messages, class_name: "Message", inverse_of: :created_by
  has_many :inbox_messages, class_name: "Message", inverse_of: :to

  def is_super_user?
    role == 'SU'
  end

  after_save do |user|
    puts "User is saved #{user}"
    SearchSuggestion.seed_update(user.email)
  end

end
