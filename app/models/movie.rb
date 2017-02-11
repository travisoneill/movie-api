class Movie < ApplicationRecord
  has_many :movie_relationships, foreign_key: :movie_id1, class_name: 'MovieRelationship'
  has_many :related_movies, through: :movie_relationships, source: :other_movie

  def json_format(url, collection=false)
    json_response = {}
    json_response[:links] = {self: url + "/movies/#{self.id}"}
    json_response[:data] = {
      type: 'movies',
      id: self.id,
      attributes: {
        title: self.title,
        description: self.description,
        year: self.year
      }
    }
    unless collection
      json_response[:relationships] = {
        related_movies: {
          links: related_movies_object(url)
        }
      }
    end
    return json_response
  end

  def build_query(request_params)
    query_object = {}
    order_object = {}
    sort_order = :asc
    case
      when request_params[:title]
        query_object[:title] = request_params[:title]
      when request_params[:year]
        years = request_params[:year].split('-')
        start_year = years[0]
        end_year = years[1] || start_year
        query_object[:year] = [start_year, end_year]
      when request_params[:description]
        query_object[:description] = request_params[:description]
      when request_params[:sort]
        sort_attr = request_params[:sort]
        order = request_params[:sort_order].downcase
        if order
          if ['d', 'desc', 'descending'].include(order)
            sort_order = :desc
          elsif ['a', 'asc', 'ascending'].include(order)
            sort_order = :asc
          else
            raise 'INVALID SORT ORDER'
          end
        end
        order_object[:sort_attr] = sort_order
    end
    puts query_object
    puts order_object
    return Movie.order(order_object).where(query_object)
  end

  private

  def related_movies_object(url)
    related_movies = {}
    self.related_movies.each do |movie|
      related_movies[movie.title] = url + "/movies/#{movie.id}"
    end
    return related_movies
  end

end
