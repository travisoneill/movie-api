class ApplicationController < ActionController::Base
  #bypass csrf security for json requests
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/vnd.api+json' }
  before_action :check_headers
  before_action :check_query_params



  # send 415 if content type header does not match specification
  def check_headers
    return if request.method == 'GET'
    if request.content_type != "application/vnd.api+json"
      render json: { errors: [ ErrorObject.new(415).object ] }, status: 415
    end
  end

  def check_query_params
    allowed = PERMITTED[request.params[:controller].to_sym] + PERMITTED[:always]
    params.each do |param|
      unless allowed.include?(param.to_sym)
        unpermitted_query
        return
      end
    end
    return unless check_sort
    return unless check_relation
  end

  def check_sort
    if params[:sort]
      allowed = SORT_ATTRS[:always] + SORT_ATTRS[request.params[:controller].to_sym]
      attribute = params[:sort][0] == '-' ? params[:sort][1..-1] : params[:sort]
      unless allowed.include?(attribute)
        unpermitted_sort
        return false
      end
    end
    return true
  end

  def check_relation
    if params[:relation]
      allowed = params[:controller].classify.constantize::INCLUDED_RELATIONS
      unless allowed.include?(params[:relation].to_sym)
        unpermitted_relation
        return false
      end
    end
    return true
  end

  def unpermitted_relation
    response = ErrorObject.new(404)
    response.set_message("Unsupported Relation Query: #{params[:relation]}")
    response.set_link('fetching-relationships')
    render json: { errors: [response] }, status: 404
  end

  def unpermitted_sort
    response = ErrorObject.new(404)
    response.set_message("Unsupported Sort Parameter: #{params[:sort]}. Supported sort params: 'title', 'year', 'id'. Add a leading '-' to sort descending.")
    response.set_link('fetching-sorting')
    render json: { errors: [response] }, status: 404
  end

  def unpermitted_query
    response = ErrorObject.new(404)
    response.set_message("Unsupported Query Parameter for '#{request.params[:controller]}'")
    response.set_link('query-parameters')
    render json: { errors: [response] }, status: 404
  end

  def url
    url = request.base_url + request.path
    if request.query_string
      url += '?' + request.query_string
    end
    return url
  end

end

#add new permitted params to an array with the key set to the controller name
PERMITTED = {
  'always': [:controller, :action],
  'movies': [:title, :year, :sort, :id, :relation],
  'movie_ratings': [:movie_rating, :data]
}

#add new permitted sort attributes here
SORT_ATTRS = {
  'always': [],
  'movies': ['title', 'year', 'id', 'rating']
}
