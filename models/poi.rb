class Poi
  include Mongoid::BaseModel
  include Mongoid::Geospatial
  include Mongoid::Enum

  # field <name>, :type => <type>, :default => <value>
  field :name, type: String
  field :category, type: String
  field :location, type: Point, sphere: true, delegate: true
  field :time_contraint, type: Hash
  field :metadata, type: Hash

  belongs_to :owner, class_name: 'User', dependent: :nullify

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>

end
