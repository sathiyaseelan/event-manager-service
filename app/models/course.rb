class Course
  include Mongoid::Document
  field :title, type: String
  field :price, type: Decimal
  field :description, type: String
  
end
