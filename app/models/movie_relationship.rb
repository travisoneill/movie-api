class MovieRelationship < ApplicationRecord
  belongs_to :movie, class_name: 'Movie', foreign_key: :movie_id1
  belongs_to :other_movie, class_name: 'Movie', foreign_key: :movie_id2
end
