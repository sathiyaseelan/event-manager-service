class AccessRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  field :new_role

  # IN_PROGRESS => P, APPROVED => A, DECLINED => D
  field :status, default: 'P'
  field :reason

  belongs_to :created_by, class_name: 'User', inverse_of: nil
  belongs_to :approved_by, class_name: 'User', inverse_of: :approved_requests
  has_one :rejected_by, class_name: 'User', inverse_of: :rejected_requests

  scope :pending, -> { where({:status => "P"}).desc(:created_at)}
  scope :rejected, -> { where({:status => "D"}).desc(:created_at)}
  scope :approved, -> { where({:status => "A"}).desc(:created_at)}

  scope :admin_only, -> {where({:new_role => "A"})}
  scope :super_user_only, -> {where({:new_role => "SU"})}
end
