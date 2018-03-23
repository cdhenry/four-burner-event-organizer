class EventsController < ApplicationController
  get '/events' do
    if logged_in?
      @public_events = Event.all.select{|event| event.public = true}
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
        event = Event.new(name: params[:name], description: params[:description], public: params[:public])
        # if !params["event_type"]["name"].empty? && !EventType.find_by(name: params["event_type"]["name"])
        #   event.event_types << EventType.new(name: params["event_type"]["name"])
        # end
        if event.save
          event.creator = current_user
          current_user.events << event
          redirect to "/users/#{current_user.id}"
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
      if params[:name] == "" || params[:event_type] == "" || params[:description] == ""
        redirect to "/events/#{params[:id]}/edit"
      else
        @event = Event.find_by_id(params[:id])
        if @event && @event.creator == current_user
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

  post '/events/:id' do
    if logged_in?
      event = Event.find_by_id(params[:id])
      if params[:attending] && !current_user.events.include?(event)
        current_user.events << event
      elsif !params[:attending]
        if current_user.events.include?(event)
          current_user.events.delete(event.id)
        end
      end
      redirect to "/users/#{current_user.id}"
    else
      redirect to '/login'
    end
  end

  delete '/events/:id/delete' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      if @event && @event.creator == current_user
        @event.delete
      end
      redirect to '/events'
    else
      redirect to '/login'
    end
  end
end
