class BurnersController < ApplicationController
  get '/users/:id/burners' do
    if params[:id] == current_user.id
      erb :'users/burners/index'
    else
      redirect to '/login'
    end
  end

  # get '/burners' do
  #   @burners = Burner.all
  #   erb :'burners/index'
  # end
  #
  # get '/burners/:slug' do
  #   @burner = Burner.find_by_slug(params[:slug])
  #   erb :'/burners/show'
  # end
end
