module Api
  class PoiRoute < Grape::API

    get :ping do
      { hello: 'poi'}
    end

    desc 'Get all pois in a neighborhood'
    params do
      requires :lon, type: Float, desc: 'Longitude of center point'
      requires :lat, type: Float, desc: 'Latitude of center point'
      requires :maxdist, type: Integer, desc: 'Maximum distance in meters'
    end
    get :neighborhood, :rabl => 'poi_list' do
          # near_sphere(
          # location: {
          # type: 'Feature',
          # geometry: {
          # type: 'Point',
          # coordinates: [params[:lon], params[:lat]]
          # }
          # }.to_json
          @pois = Poi.where(:location.near_sphere => [params[:lon], params[:lat]]
          ).max_distance(location: params[:maxdist] / 6371000.0)
    end

    desc 'Get poi detail'
    params do
      requires :id, type: Integer, desc: 'The Poi\'s identifier'
    end
    get :detail do
      @poi = Poi.find(params[:id])
    end

  end
end