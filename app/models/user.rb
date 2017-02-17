class User < ApplicationRecord
  has_many :movies_rated, class_name: 'MovieRating', foreign_key: :user_id

  def self.get_current(session)
    security_disabled = true
    if security_disabled
      return User.all.sample
    else
      return User.find_by(session: session)
    end
  end

end
