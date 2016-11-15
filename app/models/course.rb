class Course
  include Mongoid::Document
  field :title, type: String
  field :price, type: String
  field :description, type: String

end
