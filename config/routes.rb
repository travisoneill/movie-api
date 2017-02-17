Rails.application.routes.draw do

  get '/movies/:id(/:relation)', to: 'movies#show'
  get '/movies', to: 'movies#index'

  post '/movie_ratings', to: 'movie_ratings#create'
  patch '/movie_ratings', to: 'movie_ratings#update'
  put '/movie_ratings', to: 'movie_ratings#update'
end
