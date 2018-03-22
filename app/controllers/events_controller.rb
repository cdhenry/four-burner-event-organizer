class EventsController < ApplicationController
  get '/events' do
    if logged_in?
      @events = Event.all
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
        @event = current_user.events.build(content: params[:content])
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
      @event = event.find_by_id(params[:id])
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
      if params[:content] == ""
        redirect to "/events/#{params[:id]}/edit"
      else
        @event = Event.find_by_id(params[:id])
        if @event && @event.creator == current_user
          if @event.update(content: params[:content])
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
      if @event && @event.creator == current_user
        @event.delete
      end
      redirect to '/events'
    else
      redirect to '/login'
    end
  end
end
