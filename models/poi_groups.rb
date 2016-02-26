class PoiGroup
  include Mongoid::BaseModel

  field :name

  belongs_to :owner, class_name: 'User'
end