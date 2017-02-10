class Movie < ApplicationRecord
  has_many :movie_relationships, foreign_key: :movie_id1, class_name: 'MovieRelationship'
  has_many :related_movies, through: :movie_relationships, source: :other_movie



  def attribute_format(attribute)
    json_response = {}
    json_response[:links] = {self: url + "/movies/#{self.id}"}

  end

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

  private

  def related_movies_object(url)
    related_movies = {}
    self.related_movies.each do |movie|
      related_movies[movie.title] = url + "/movies/#{movie.id}"
    end
    return related_movies
  end

end
