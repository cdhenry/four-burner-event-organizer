class UsersController < ApplicationController
  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/events'
    end
  end

  post '/signup' do
    if User.all.find_by(email: params[:email])
      redirect to '/login'
    elsif params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(name: params[:name], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/events'
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/events'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/events"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
