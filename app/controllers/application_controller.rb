class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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
    if params[:sort]
      check_sort
    end
  end

  def check_sort
    if params[:sort]
      # byebug
      allowed = SORT_ATTRS[:always] + SORT_ATTRS[request.params[:controller].to_sym]
      attribute = params[:sort][0] == '-' ? params[:sort][1..-1] : params[:sort]
      unless allowed.include?(attribute)
        unpermitted_sort
      end
    end
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

end

#add new permitted params to an array with the key set to the controller name
PERMITTED = {
  'always': [:controller, :action],
  'movies': [:title, :year, :sort, :id, :related_movies],
  'movie_ratings': [:movie_id, :rating, :movie_rating]
}

#add new permitted sort attributes here
SORT_ATTRS = {
  'always': [],
  'movies': ['title', 'year', 'id']
}
