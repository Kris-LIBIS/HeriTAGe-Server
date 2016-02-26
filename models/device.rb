class Device
  include Mongoid::BaseModel
  include Mongoid::Geospatial
  include Mongoid::Uuid

  field :last_loc, type: Point, sphere: true, delegate: true

  belongs_to :user, class_name: 'User', dependent: :restrict
end
