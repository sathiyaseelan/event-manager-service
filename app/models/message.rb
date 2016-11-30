class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  belongs_to :created_by, class_name: "User", inverse_of: :outbox_messages
  belongs_to :to, class_name: "User", inverse_of: :inbox_messages
end
