class MoviesController < ApplicationController

  def show
    @movie = Movie.find_by(id: params[:id])
    if params[:relation]
      data = @movie&.send(params[:relation])&.map { |rel| rel.resource_json( {rating: rel.average_rating}, true ) } || []
      render json: { links: { self: url }, data: data }
    elsif @movie
      render json: @movie.resource_json({ rating: @movie.average_rating })
    else
      render json: { links: { self: url }, data: nil }
    end
  end


  def index
    @movies = Movie.build_query(params)
    render json: {
      links: { self: url },
      data: @movies.map { |movie| movie.resource_json( {rating: movie.average_rating}, true ) }
    }
  end

end
