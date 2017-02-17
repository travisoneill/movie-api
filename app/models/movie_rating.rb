class MovieRating < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  INCLUDED_RELATIONS = []

end
