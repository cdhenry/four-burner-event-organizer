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

    def create_four_burners(user)
      user.burners << Burner.create(name: "Family")
      user.burners << Burner.create(name: "Friends")
      user.burners << Burner.create(name: "Work")
      user.burners << Burner.create(name: "Health")
    end
  end
end
