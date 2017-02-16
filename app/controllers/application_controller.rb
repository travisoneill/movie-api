class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_headers
  before_action :check_query_params

  # send 415 if content type header does not match specification
  def check_headers
    # byebug
    return if request.method == 'GET'
    if request.content_type != "application/vnd.api+json"
      render json: { errors: [ ErrorObject.new(415).object ] }, status: 415
    end
  end

  def check_query_params
    # byebug
    allowed = PERMITTED[request.params[:controller].to_sym]
    #TODO: FIX DEPRECATION ISSUE
    if params[:sort]
      check_sort
    end
    ActionController::Parameters.new(request.params).permit(*allowed)
  end

  def check_sort
    sort_attrs = ['title', 'year', 'id']
    if params[:sort]
      attribute = params[:sort][0] == '-' ? params[:sort][1..-1] : params[:sort]
      unless sort_attrs.include?(attribute)
        response = ErrorObject.new(404)
        response.set_message("Unsupported Sort Parameter: #{params[:sort]}. Supported sort params: 'title', 'year', 'id'. Add a leading '-' to sort descending.")
        response.set_link('fetching-sorting')
        render json: { errors: [response] }, status: 404
      end
    end
  end

end

#add new permitted params to an array with the key set to the controller name
PERMITTED = {
  'movies': [:title, :year, :sort, :id]
}
