require 'mongoid/sequence'

module Mongoid
  module BaseModel

    def self.included(klass)
      klass.class_eval do
        include Mongoid::Document
        include Mongoid::Timestamps::Short
        include Mongoid::Sequence
        field :_id, type: Integer, overwrite: true
        sequence :_id
        index c_at: 1
      end
    end
  end
end
