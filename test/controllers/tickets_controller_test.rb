require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
	test "should get get_pdf" do
		get tickets_get_pdf_url
		assert_response :success
	end

end
