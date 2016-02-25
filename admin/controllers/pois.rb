Webserver::Admin.controllers :pois do
  get :index do
    @title = "Pois"
    @pois = Poi.all
    render 'pois/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'poi')
    @poi = Poi.new
    render 'pois/new'
  end

  post :create do
    @poi = Poi.new(params[:poi])
    if @poi.save
      @title = pat(:create_title, :model => "poi #{@poi.id}")
      flash[:success] = pat(:create_success, :model => 'Poi')
      params[:save_and_continue] ? redirect(url(:pois, :index)) : redirect(url(:pois, :edit, :id => @poi.id))
    else
      @title = pat(:create_title, :model => 'poi')
      flash.now[:error] = pat(:create_error, :model => 'poi')
      render 'pois/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "poi #{params[:id]}")
    @poi = Poi.find(params[:id])
    if @poi
      render 'pois/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'poi', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "poi #{params[:id]}")
    @poi = Poi.find(params[:id])
    if @poi
      if @poi.update_attributes(params[:poi])
        flash[:success] = pat(:update_success, :model => 'Poi', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:pois, :index)) :
          redirect(url(:pois, :edit, :id => @poi.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'poi')
        render 'pois/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'poi', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Pois"
    poi = Poi.find(params[:id])
    if poi
      if poi.destroy
        flash[:success] = pat(:delete_success, :model => 'Poi', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'poi')
      end
      redirect url(:pois, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'poi', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Pois"
    unless params[:poi_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'poi')
      redirect(url(:pois, :index))
    end
    ids = params[:poi_ids].split(',').map(&:strip)
    pois = Poi.find(ids)
    
    if pois.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Pois', :ids => "#{ids.join(', ')}")
    end
    redirect url(:pois, :index)
  end
end
