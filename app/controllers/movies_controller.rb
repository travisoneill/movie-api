class MoviesController < ApplicationController

  def show
    # byebug
    @movie = Movie.find(params[:id])
    if params[:relation] == 'related'
      render json: @movie.related_movies.map { |rel| rel.json_format(request.base_url, collection=true) }
    else
      render json: @movie.json_format(request.base_url)
    end
  end


  def index
    # byebug
    @movies = Movie.build_query(params)
    render json: @movies.map { |movie| movie.json_format(request.base_url, collection=true) }
  end

end
