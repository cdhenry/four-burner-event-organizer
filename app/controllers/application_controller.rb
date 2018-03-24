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

    def percent_time_with(burner_group)
      hours_spent = 0.0

      burner_group.each do |event|
        hours_spent += event.duration
      end

      ((hours_spent / time_total) * 100).round(1)
    end

    def time_total
      total_time_spent = 0

      current_user.events.each do |event|
        total_time_spent += event.duration
      end

      total_time_spent
    end

    def users_events
      burner_hash = Hash.new
      events = Event.all.select {|event| event.user == current_user}

      burner_hash["Friends"] = events.select{|event| event.burners.find_by(name: "Friends")}
      burner_hash["Family"] = events.select{|event| event.burners.find_by(name: "Family")}
      burner_hash["Work"] = events.select{|event| event.burners.find_by(name: "Work")}
      burner_hash["Health"] = events.select{|event| event.burners.find_by(name: "Health")}

      burner_hash
    end
  end
end
