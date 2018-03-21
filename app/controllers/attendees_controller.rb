class AttendeesController < ApplicationController
  get '/attendees/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'attendees/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'attendees/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/events'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = Attendee.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/events'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'attendees/login'
    else
      redirect '/events'
    end
  end

  post '/login' do
    user = Attendee.find_by(:name => params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/events"
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
