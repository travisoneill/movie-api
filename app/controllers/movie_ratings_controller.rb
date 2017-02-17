class MovieRatingsController < ApplicationController
  #bypass csrf security for json requests
  before_action :validate_params

  def validate_params
    @user = User.get_current(request.headers['fandor_session'])
    unless @user
      return invalid_session
    end
    movie_id = params[:data][:attributes][:movie_id]
    @movie = Movie.find_by(id: movie_id)
    unless @movie
      return invalid_movie
    end
    @movie_rating = MovieRating.find_by({ user_id: @user.id, movie_id: @movie.id })&.resource_json
  end

  def create
    if @movie_rating
      rating_conflict
    else
      rating = params[:data][:attributes][:rating]
      @movie_rating = MovieRating.new({ user_id: @user.id, movie_id: @movie.id, rating: rating })
      begin
        @movie_rating.save!
      rescue => error
        response = ErrorObject.new(500)
        response.set_message("Database error saving object: #{error}")
        render json: { errors: [response] }, status: 500
      else
        render json: @movie_rating.resource_json, status: 202
      end
    end
  end

  def update
    if @movie_rating
      rating_id = @movie_rating[:data][:id]
      attrs = params[:data][:attributes]
      rating = params[:data][:attributes][:rating]
      @movie_rating = MovieRating.find_by(id: rating_id)
      begin
        @movie_rating.update!(rating: rating)
      rescue => error
        response = ErrorObject.new(500)
        response.set_message("Database error updating object: #{error}")
        render json: { errors: [response] }, status: 500
      else
        render json: MovieRating.find_by(id: rating_id).resource_json, status: 202
      end
    else
      update_non_existant
    end

  end

  def invalid_movie
    response = ErrorObject.new(404)
    response.set_message("Movie Not in Database")
    render json: { errors: [response.object] }, status: 404
  end

  def invalid_session
    response = ErrorObject.new(403)
    response.set_message("User Not Logged In.  Go to #{request.base_url}/login")
    render json: { errors: [response.object] }, status: 403
  end

  def rating_conflict
    response = ErrorObject.new(409)
    response.set_message("Movie already rated by this user")
    render json: { errors: [response.object] }, status: 409
  end

  def update_non_existant
    response = ErrorObject.new(409)
    response.set_message("Cannot update because user has not rated this movie")
    render json: { errors: [response.object] }, status: 409
  end

end
