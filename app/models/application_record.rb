class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def base_url
    if ENV['RAILS_ENV'] = 'development'
      return 'http://localhost:3000/'
    elsif ENV['RAILS_ENV'] = 'production'
      return ''
    else
      return 'http://localhost:3000'
    end
  end

  def controller_name
    self.class.to_s.underscore.pluralize
  end

  def resource_json
    json_response = {}
    json_response[:links] = {self: base_url + "/" + controller_name + "/#{self.id}"}
    json_response[:data] = {
      type: controller_name,
      id: self.id,
      attributes: {
        title: self.title,
        rating: self.average_rating,
        description: self.description,
        year: self.year
      }
    }
    # unless collection
    #   json_response[:relationships] = {
    #     related_movies: {
    #       links: related_movies_object(url)
    #     }
    #   }
    # end
    return json_response
  end


end
