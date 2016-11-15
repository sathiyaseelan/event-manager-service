class Note
  include Mongoid::Document
  field :content, type: String
  field :tags, type: Array
  belongs_to :user
end
