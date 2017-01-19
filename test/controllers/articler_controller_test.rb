require 'test_helper'

class ArticleControllerControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
        get article_controller_index_url
        assert_response :success
    end

    test 'should get show' do
        get article_controller_show_url
        assert_response :success
    end

end
