class User
  include Mongoid::BaseModel

  field :name
  field :email

  has_many :devices, class_name: 'Device', dependent: :restrict
end