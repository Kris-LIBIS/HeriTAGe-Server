require 'mongoid/sequence'

module Mongoid
  class BaseModel
    include Mongoid::Document
    include Mongoid::Timestamps::Short

    include Mongoid::Sequence
    field :_id, type: Integer, overwrite: true
    sequence :_id
    index c_at: 1
  end
end
