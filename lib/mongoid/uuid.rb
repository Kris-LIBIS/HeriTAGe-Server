module Mongoid
  module Uuid
    extend ActiveSupport::Concern
    include Mongoid::Uuid::Uuid

    def self.validate(uuid)
      UUID.validate(uuid)
    end

  end
end

ActiveModel::Validations.send(:include, Mongoid::Uuid::Validator)
