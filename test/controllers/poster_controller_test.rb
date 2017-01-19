require 'test_helper'

class PosterControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
        get poster_index_url
        assert_response :success
    end

end
