class EventTypesController < ApplicationController
  get '/burners' do
    @burners = Burner.all
    erb :'burners/index'
  end

  get '/burners/:slug' do
    @burner = Burner.find_by_slug(params[:slug])
    erb :'/burners/show'
  end
end
