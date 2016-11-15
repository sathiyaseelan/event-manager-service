class Activity
  include Mongoid::Document
  field :title, type: String
  field :schedule_date, type: DateTime
  field :price, type: String
  field :description, type: String
end
