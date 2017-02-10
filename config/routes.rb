Rails.application.routes.draw do

get '/movies/:id(/:related)', to: 'movies#show'
get '/movies', to: 'movies#index'

end
