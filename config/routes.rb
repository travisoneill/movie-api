Rails.application.routes.draw do

get '/movies/:id(/:relation)', to: 'movies#show'
get '/movies', to: 'movies#index'

end
