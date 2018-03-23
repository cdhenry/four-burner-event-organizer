# class EventTypesController < ApplicationController
#   get '/event_types' do
#     @event_types = EventType.all
#     erb :'event_types/index'
#   end
#
#   get '/event_types/:slug' do
#     @event_type = EventType.find_by_slug(params[:slug])
#     erb :'/event_types/show'
#   end
# end
