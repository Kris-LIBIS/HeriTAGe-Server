require 'resources/poi'
require 'resources/device'
require 'resources/user'

module Api
  class Main < Grape::API
    version 'v1', using: :accept_version_header
    format :json
    formatter :json, Grape::Formatter::Rabl

    get :hello do
      { hello: 'grape' }
    end

    group(:poi) { mount(Api::Poi) }
    group(:device) { mount(Api::Device) }
    group(:user) { mount(Api::User) }
  end
end