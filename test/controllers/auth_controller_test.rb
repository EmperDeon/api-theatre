require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
    test 'should get auth' do
        get auth_auth_url
        assert_response :success
    end

    test 'should get refresh' do
        get auth_refresh_url
        assert_response :success
    end

    test 'should get check' do
        get auth_check_url
        assert_response :success
    end

    test 'should get perms' do
        get auth_perms_url
        assert_response :success
    end

end
