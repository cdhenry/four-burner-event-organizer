class EventsController < ApplicationController
  get '/events' do
    if logged_in?
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
      if params[:description] == "" || params[:name] == "" || params[:hours] == "" || params[:split] == "" || !params[:burner_ids]
        redirect to "/events/new"
      else
        @event = Event.new(name: params[:name], description: params[:description].strip, date: params[:date], duration: (params[:hours]+params[:split]).to_f)
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
      if @event && @event.user == current_user
        erb :'events/show'
      else
        redirect to '/events'
      end
    else
      redirect to '/login'
    end
  end

  get '/events/:id/edit' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      if @event && @event.user == current_user
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
      if params[:name] == "" || params[:description] == "" || params[:hours] == "" || params[:split] == "" || !params[:burner_ids]
        redirect to "/events/#{params[:id]}/edit"
      else
        @event = Event.find_by_id(params[:id])
        if @event && @event.user == current_user
          if @event.update(name: params[:name], description: params[:description].strip, duration: (params[:hours]+params[:split]).to_f)
            @event.burner_ids = params[:burner_ids]
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
