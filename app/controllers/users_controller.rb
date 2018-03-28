require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      flash[:message] = "***Log out to sign up as a new user."
      redirect to '/'
    end
  end

  post '/signup' do
    if User.all.find_by(email: params[:email])
      flash[:message] = "***You already have an account."
      redirect to '/login'
    elsif params[:name] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "***All fields must be filled out."
      redirect to '/signup'
    else
      @user = User.new(name: params[:name], email: params[:email].downcase, password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/'
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      flash[:message] = "***You're already logged in."
      redirect to '/events'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/events"
    else
      flash[:message] = "***Sign up to log in!"
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      flash[:message] = "***You are not logged in."
      redirect to '/'
    end
  end
end
