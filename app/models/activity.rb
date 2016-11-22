class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Helper::Pagination

  field :name, type: String
  field :price, type: Float
  field :description, type: String
  field :languages, type: Array
  field :status, type: String
  field :amenities, type: Array
  field :contactPerson
  field :contactNumber
  field :contactEmail
  field :paymentType
  field :imageUrl
  field :parking, type: Array
  field :ratings, type: Integer
  field :address
  field :startFrom
  field :scheduleType
  field :schedule, type: DateTime
  field :duration, type: String

  belongs_to :category

  belongs_to :created_by, class_name: "User", inverse_of: :created_activities

  has_and_belongs_to_many :enrolled_users, class_name: "User" , inverse_of: :enrolled_activities

  scope :upcoming, ->(limit = 10){ where({:schedule.gte => Time.now}).asc(:schedule)}
end
