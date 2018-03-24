class EventsController < ApplicationController
  get '/events' do
    if logged_in?
      users_events = Event.all.select {|event| event.user == current_user}
      @friends = users_events.select{|event| event.burners.find_by(name: "Friends")}
      @family = users_events.select{|event| event.burners.find_by(name: "Family")}
      @work = users_events.select{|event| event.burners.find_by(name: "Work")}
      @health = users_events.select{|event| event.burners.find_by(name: "Health")}
      erb :'events/index'
    else
      redirect to '/login'
    end
  end

  get '/events/new' do
    if logged_in?
      erb :'events/new'
    else
      redirect to '/login'
    end
  end

  post '/events' do
    if logged_in?
      if params[:description] == "" || params[:name] == ""
        redirect to "/events/new"
      else
        @event = Event.new(name: params[:name], description: params[:description], date: params[:date], duration: (params[:hours]+params[:split]).to_f)
        @event.burner_ids = params[:burner_ids]
        @event.user = current_user
        if @event.save
          redirect to "/events/#{@event.id}"
        else
          redirect to "/events/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/events/:id' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      erb :'events/show'
    else
      redirect to '/login'
    end
  end

  get '/events/:id/edit' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      if @event && @event.creator == current_user
        erb :'events/edit'
      else
        redirect to '/events'
      end
    else
      redirect to '/login'
    end
  end

  patch '/events/:id' do
    if logged_in?
      if params[:name] == "" || params[:description] == "" || params[:date_and_time] == ""
        redirect to "/events/#{params[:id]}/edit"
      else
        @event = Event.find_by_id(params[:id])
        if @event && @event.user == current_user
          if @event.update(name: params[:name], description: params[:description])
            redirect to "/events/#{@event.id}"
          else
            redirect to "/events/#{@event.id}/edit"
          end
        else
          redirect to '/events'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/events/:id/delete' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      if @event && @event.user == current_user
        @event.delete
      end
      redirect to '/events'
    else
      redirect to '/login'
    end
  end
end
