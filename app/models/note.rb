class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :content, type: String
  field :tags, type: Array
  belongs_to :user
end
