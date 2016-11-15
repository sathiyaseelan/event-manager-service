class Booking
  include Mongoid::Document
  field :id, type: String
  belongs_to :user, dependent: :destroy
  has_one :activity, inverse_of: nil
  has_one :course, inverse_of: nil
end
