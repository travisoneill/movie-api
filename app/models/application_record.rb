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

  def url
    base_url + '/' + controller_name + '/' + self.id.to_s
  end

  def self.controller_name
    self.to_s.underscore.pluralize
  end

  def controller_name
    self.class.controller_name
  end

  def resource_json(additional_attributes={}, collection_member=false)
    json_response = {}
    json_response[:links] = {self: self.url}
    json_response[:data] = {
      type: controller_name,
      id: self.id,
      attributes: self.attributes.except('created_at', 'updated_at', 'id').merge(additional_attributes)
    }
    unless collection_member
      json_response[:relationships] = relationship_object
    end
    return json_response
  end

  def relationship_object
    relation_obj = {}
    relationships = self.class::INCLUDED_RELATIONS
    relationships.each do |relation|
      controller = self.class.reflect_on_association(relation).class_name.constantize.controller_name
      links = { related: base_url + '/' + controller + '/' + self.id.to_s + '/' + relation.to_s }
      data = []
      included_resources = self.send(relation)
      included_resources.each do |resource|
        data << { id: resource.id, type: resource.class.controller_name }
      end
      data = data[0] if data.length == 1
      data = nil if data.length == 0
      relation_obj[relation] = { links: links, data: data }
    end
    return relation_obj
  end


end
