class BurnersController < ApplicationController
  get '/burners' do
    @burners = Burner.all
    users_events.collect do |burner, events|
      burner => events.collect {|event| event.duration}.sum}
    end
    erb :'burners/index'
  end

  get '/burners/:slug' do
    @burner = current_user.burners.find_by_slug(params[:slug])
    erb :'/burners/show'
  end
end
