class MovieRatingsController < ApplicationController
  #bypass csrf security for json requests
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/vnd.api+json' }
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
    @movie_rating = MovieRating.find_by({ user_id: @user.id, movie_id: @movie.id })
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
    unless @movie_rating

    end

  end

  def invalid_movie
    response = ErrorObject.new(404)
    response.set_message("Movie Not in Database")
    render json: { errors: [response] }, status: 404
  end

  def invalid_session
    response = ErrorObject.new(403)
    response.set_message("User Not Logged In.  Go to #{request.base_url}/login")
    render json: { errors: [response] }, status: 403
  end

  def rating_conflict
    response = ErrorObject.new(409)
    response.set_message("Movie already rated by this user")
    render json: { errors: [response] }, status: 409
  end

end
