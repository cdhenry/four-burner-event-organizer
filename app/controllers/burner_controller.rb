require 'rack-flash'

class BurnersController < ApplicationController
  use Rack::Flash

  get '/burners' do
    if logged_in?
      if current_user.burners.empty?
        flash[:message] = "***You have no events for the burner breakdown to chart."
        redirect to '/events'
      else
        @burners = current_user.burners.uniq

        #for the google pie-chart app
        percent_time_spent_array = users_events.collect do |burner, events|
          "['#{burner}', #{events.collect {|event| event.duration}.sum}]"
        end
        @chart_breakdown = percent_time_spent_array.join(",")

        erb :'burners/index'
      end
    else
      flash[:message] = "***Log in to view this page."
      redirect to '/login'
    end
  end

  get '/burners/:slug' do
    if logged_in?
      @events = current_user.events.select {|event| event.burners.find_by_slug(params[:slug])}
      erb :'/burners/show'
    else
      flash[:message] = "***Log in to view this page."
      redirect to '/login'
    end
  end
end
