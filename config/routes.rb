Rails.application.routes.draw do

get '/movies/:id', to: 'movies#show' 

end
