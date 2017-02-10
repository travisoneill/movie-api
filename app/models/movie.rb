class Movie < ApplicationRecord
  has_many :movie_relationships, foreign_key: :movie_id1, class_name: 'MovieRelationship'
  has_many :related_movies, through: :movie_relationships, source: :other_movie


  def json_format(url)
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
    json_response[:relationships] = {
      links: {
        related: self.related_movies.map { |mov| url + "/movies/#{mov.id}" }
      }
    }
    return json_response
  end

end
