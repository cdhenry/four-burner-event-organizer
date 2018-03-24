require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "balance"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def time_with(burner_group)
      hours_spent = 0.0
      burner_group.each do |event|
        hours_spent += event.duration.to_i
      end
      hours_spent
    end
  end
end
