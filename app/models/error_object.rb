class ErrorObject
  extend ActiveModel::Naming
  attr_accessor :object

  def initialize(status_code)
    @object = {
      status: status_code,
      title: get_title(status_code),
      detail: get_detail(status_code),
      links: {
        about: get_link(status_code)
      }
    }
  end

  def get_title(code)
    case code
    when 415
      'Unsupported Media Type'
    when 406
      'Not Acceptable'
    when 404
      'Bad Request'
    when 403
      'Forbidden'
    when 409
      'Conflict'
    when 500
      'Internal Server Error'  
    end
  end

  def set_link(error_type)
    @object[:links][:about] = 'http://jsonapi.org/format/' + error_type
  end

  def set_message(message)
    @object[:detail] = message
  end

  def get_detail(code)
    case code
    when 415
      "Requests must contain content type header 'application/vnd.api+json' header per JSON API specification"
    end
  end

  def get_link(code)
    case code
    when 415, 406
      "http://jsonapi.org/format/#content-negotiation"
    end
  end

end
