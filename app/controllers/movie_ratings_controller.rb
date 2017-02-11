class MovieRatingsController < ApplicationController
  #bypass csrf security for json requests
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def create_or_update
    @movie_rating = MovieRating.find_by({
      user_id: params[:user_id],
      movie_id: params[:movie_id]
    })
    if @movie_rating
      if @movie_rating.update!({ rating: params[:rating] })
        render json: @movie_rating
      else
        render json: { error: 'ERROR UPDATING MOVIE RATING' }
      end
    else
      @movie_rating = MovieRating.new({
        user_id: params[:user_id],
        movie_id: params[:movie_id],
        rating: params[:rating]
      })
      if @movie_rating.save!
        render json: @movie_rating
      else
        render json: { error: 'ERROR CREATING MOVIE RATING' }
      end
    end
  end

end
