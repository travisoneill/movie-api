Rails.application.routes.draw do

  get '/movies/:id(/:relation)', to: 'movies#show'
  get '/movies', to: 'movies#index'

  post '/movies/rate/:movie_id/:rating', to: 'movie_ratings#create'
  patch '/movies/rate/movie_id/:rating/edit', to: 'movie_ratings#update'
end
