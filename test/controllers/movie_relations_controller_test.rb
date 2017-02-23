require 'test_helper'

class MovieRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get movie_relations_show_url
    assert_response :success
  end

end
