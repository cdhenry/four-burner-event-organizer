class BurnersController < ApplicationController
  get '/burners' do
    if logged_in?
      @burners = Burner.all
      #@duration_hash = {}
      duration_array = users_events.collect do |burner, events|
        "['#{burner}', #{events.collect {|event| event.duration}.sum}]"
        #@duration_hash[burner] = events.collect {|event| event.duration}.sum
      end
      @chart_breakdown = duration_array.join(",")
      erb :'burners/index'
    else
      redirect to '/login'
    end
  end

  get '/burners/:slug' do
    if logged_in?
      @burner = current_user.burners.find_by_slug(params[:slug])
      erb :'/burners/show'
    else
      redirect to '/login'
    end
  end
end
