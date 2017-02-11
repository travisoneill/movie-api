class MoviesController < ApplicationController

  def show
    # byebug
    url = request.base_url + request.path + request.query_string
    @movie = Movie.find(params[:id])
    if params[:relation] == 'related'
      render json: {
        links: { self: url },
        data: @movie.related_movies.map { |rel| rel.json_format(request.base_url, collection=true) }
      }
    else
      render json: @movie.json_format(request.base_url)
    end
  end


  def index
    # byebug
    url = request.base_url + request.path + request.query_string
    @movies = Movie.build_query(params)
    render json: {
      links: { self: url },
      data: @movies.map { |movie| movie.json_format(request.base_url, collection=true) }
    }
  end

end
