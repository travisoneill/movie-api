class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    render json: @movie.json_format(request.base_url)
  end


  def index

  end

  # private
  # def movie_params
  #   params.require()
  # end

end
