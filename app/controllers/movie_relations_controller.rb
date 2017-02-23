class MovieRelationsController < ApplicationController
  def show
    @movie = Movie.find_by(id: params[:movie_id])
    data = @movie&.send(params[:id])&.map { |rel| rel.resource_json( {rating: rel.average_rating}, true ) } || []
    render json: { links: { self: url }, data: data }
  end
  
end
