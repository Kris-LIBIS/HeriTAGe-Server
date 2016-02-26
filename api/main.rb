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

    group(:poi) { mount(Api::PoiRoute) }
    group(:device) { mount(Api::DeviceRoute) }
    group(:user) { mount(Api::UserRoute) }
  end
end