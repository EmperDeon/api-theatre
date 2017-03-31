require 'test_helper'

class TPricesControllerTest < ActionDispatch::IntegrationTest
	setup do
		@t_price = t_prices(:one)
	end

	test "should get index" do
		get t_prices_url, as: :json
		assert_response :success
	end

	test "should create t_price" do
		assert_difference('TPrice.count') do
			post t_prices_url, params: {t_price: {}}, as: :json
		end

		assert_response 201
	end

	test "should show t_price" do
		get t_price_url(@t_price), as: :json
		assert_response :success
	end

	test "should update t_price" do
		patch t_price_url(@t_price), params: {t_price: {}}, as: :json
		assert_response 200
	end

	test "should destroy t_price" do
		assert_difference('TPrice.count', -1) do
			delete t_price_url(@t_price), as: :json
		end

		assert_response 204
	end
end
