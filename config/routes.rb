Rails.application.routes.draw do

  get '/movies/:id(/:relation)', to: 'movies#show'
  get '/movies', to: 'movies#index'

  post '/movies/:movie_id/rate/:user_id/:rating', to: 'movie_ratings#create_or_update'

end
