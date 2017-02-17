class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def base_url
    if ENV['RAILS_ENV'] = 'development'
      return 'http://localhost:3000'
    elsif ENV['RAILS_ENV'] = 'production'
      return ''
    else
      return ''
    end
  end

  def self.controller_name
    self.to_s.underscore.pluralize
  end

  def controller_name
    self.class.controller_name
  end

  def resource_json
    collection = false
    json_response = {}
    json_response[:links] = {self: base_url + "/" + controller_name + "/#{self.id}"}
    json_response[:data] = {
      type: controller_name,
      id: self.id,
      attributes: self.attributes.except('created_at', 'updated_at', 'id')
    }
    # json_response[:relationships] = {}
    relationships = self.class::INCLUDED_RELATIONS
    unless collection
      relationships.each do |relation|
        controller = self.class.reflect_on_association(relation).class_name.constantize.controller_name
        links = { related: base_url + '/' + controller + '/' + self.id.to_s + '/' + relation.to_s }
        data = []
        included_resources = self.send(relation)
        included_resources.each do |resource|
          data << { id: resource.id, type: resource.class.controller_name }
        end
        data = nil if data.length == 0
        data = data[0] if data.length == 1
        relation_obj = { links: links, data: data }
        json_response[:relationships] = {} unless json_response[:relationships]
        json_response[:relationships][relation] = relation_obj
      end
    end
    return json_response
  end


end
