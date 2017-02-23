Rails.application.routes.draw do

  # get 'movie_relations/show'
  resources :movies, only: [:show, :index] do
    resources :movie_relations, only: [:show]
  end
  # get '/movies/:id', to: 'movies#show'
  # get '/movies', to: 'movies#index'

  # get '/movies/:id/:relation', to: 'movie_relations#index'


  post '/movie_ratings', to: 'movie_ratings#create'
  patch '/movie_ratings', to: 'movie_ratings#update'
  put '/movie_ratings', to: 'movie_ratings#update'

end
