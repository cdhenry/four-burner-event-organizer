class BurnersController < ApplicationController
  get '/users/:id/burners' do
    binding.pry
    if params[:id] == session[:user_id]
      erb :"users/#{curent_user.id}/burners"
    else
      redirect to '/login'
    end
  end

  get '/burners' do
    @burners = Burner.all
    erb :'burners/index'
  end

  get '/burners/:slug' do
    @burner = Burner.find_by_slug(params[:slug])
    erb :'/burners/show'
  end
end
