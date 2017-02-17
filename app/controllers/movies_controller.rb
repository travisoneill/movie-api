class MoviesController < ApplicationController

  def show
    # byebug
    url = request.base_url + request.path + request.query_string
    @movie = Movie.find_by(id: params[:id])
    if params[:relation]
      render json: {
        links: { self: url },
        data: @movie.send(params[:relation]).map { |rel| rel.json_format(request.base_url, collection=true) }
      }
    elsif @movie
      render json: @movie.json_format(request.base_url)
    else
      render json
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
