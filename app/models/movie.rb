class Movie < ApplicationRecord
  has_many :movie_relationships, foreign_key: :movie_id1, class_name: 'MovieRelationship'
  has_many :related_movies, through: :movie_relationships, source: :other_movie
  has_many :ratings, class_name: 'MovieRating', foreign_key: :movie_id

  #Set relations to be included in response
  INCLUDED_RELATIONS = [:related_movies]

  def average_rating
    return self.ratings.average(:rating).to_f
  end

  def self.build_query(request_params)
    query_object = {}
    order_object = {}
    sort_order = :asc

    if request_params[:title]
      query_object[:title] = request_params[:title]
    end

    if request_params[:year]
      years = request_params[:year].split('-')
      start_year = years[0]
      end_year = years[1] || start_year
      query_object[:year] = (start_year..end_year)
    end

    if request_params[:sort]
      if request_params[:sort][0] == '-'
        order_object[request_params[:sort][1..-1].to_sym] = :desc
      else
        order_object[request_params[:sort]] = :asc
      end
    end

    return Movie.order(order_object).where(query_object)
  end

end
