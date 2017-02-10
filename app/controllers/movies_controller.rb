class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    response = {}
    response[:links] = {self: request.base_url + "/movies/#{params[:id]}"}
    response[:data] = {
      type: 'movies',
      id: params[:id],
      attributes: {
        title: @movie.title,
        description: @movie.description,
        year: @movie.year
      }
    }
    response[:relationships] = {
      links: {
        related: @movie.related_movies.map { |mov| request.base_url + "/movies/#{mov.id}" }
      }
    }
    render json: response
  end


  def index

  end

  # private
  # def movie_params
  #   params.require()
  # end

end
