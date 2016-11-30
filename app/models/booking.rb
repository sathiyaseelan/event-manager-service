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

  belongs_to :user #, dependent: :destroy

  has_one :activity, inverse_of: nil
  has_one :course, inverse_of: nil
end
