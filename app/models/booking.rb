class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :type, type: String # recurring or single
  field :status, type: String
  field :total_count, type: Integer
  field :child_count, type: Integer
  field :adult_count, type: Integer
  field :price, type: Float
  field :imageUrl, type: String

  belongs_to :activity, inverse_of: :bookings
  belongs_to :course, inverse_of: :bookings

  belongs_to :created_by, class_name: "User", inverse_of: :bookings
end
