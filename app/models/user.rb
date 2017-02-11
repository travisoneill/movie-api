class User < ApplicationRecord
  has_many :movies_rated, class_name: 'MovieRating', foreign_key: :user_id

end
