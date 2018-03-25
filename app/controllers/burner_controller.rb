class BurnersController < ApplicationController
  get '/burners' do
    if logged_in?
      if current_user.burners.empty?
        redirect to '/events'
      else
        @burners = current_user.burners
        duration_array = users_events.collect do |burner, events|
          "['#{burner}', #{events.collect {|event| event.duration}.sum}]"
        end
        @chart_breakdown = duration_array.join(",")
        erb :'burners/index'
      end
    else
      redirect to '/login'
    end
  end

  get '/burners/:slug' do
    if logged_in?
      @events = current_user.events.collect do |event|
        event if event.burners.find_by_slug(params[:slug])
      end
      erb :'/burners/show'
    else
      redirect to '/login'
    end
  end
end
