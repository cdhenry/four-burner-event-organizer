class BurnersController < ApplicationController
  get '/burners' do
    if logged_in?
      if current_user.burners.empty?
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
      redirect to '/login'
    end
  end

  get '/burners/:slug' do
    if logged_in?
      @events = current_user.events.select {|event| event.burners.find_by_slug(params[:slug])}
      erb :'/burners/show'
    else
      redirect to '/login'
    end
  end
end
