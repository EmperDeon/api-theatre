class ApplicationController < ActionController::API
	attr_reader :current_user

	#
	# For 'before_action' method
	#
	protected

	# For API Auth
	def check_api_token
		check_token ::UApi
	end

	# For Web Auth
	def check_web_token
		check_token ::UWeb
	end


	#
	# JSON responses
	#
	private

	# Render json for normal response
	#  obj:: object
	def res (obj, s = 200)
		render json: {response: obj}, status: s
	end

	# Render json for error
	#  e:: error name
	#  m:: error message/description
	#  s:: status code
	def err (e, m, s)
		render json: {error: e, message: m}, status: s
	end


	#
	# Exceptions rescue
	#
	rescue_from ActiveRecord::RecordNotFound, with: lambda { |e| err('no_id', e.message, :not_found) }
	rescue_from ActiveRecord::RecordInvalid, with: lambda { |e| err('validation_error', e.message, :unprocessable_entity) }


	#
	# Auth helper methods
	#

	# Check token for specified class
	#  cl:: Model class object
	#
	def check_token (cl)
		unless user_id_in_token?
			err 'no_token', 'Not Authenticated', :unauthorized
			return
		end

		user = cl.find(auth_token[:user_id])

		if user.login == auth_token[:login]
			@current_user = user

		else
			# If user try to login with API token to Web
			err 'no_token', 'Not Authenticated', :unauthorized
		end

	rescue JWT::VerificationError, JWT::DecodeError
		err 'no_token', 'Not Authenticated', :unauthorized
	end

	# Decode JWT Token to user data
	#
	def auth_token
		@auth_token = JsonWebToken.decode(params[:token])
	end

	# Is user id in token ?
	#
	def user_id_in_token?
		auth_token && auth_token[:user_id].present? && auth_token[:login].present?
	end
end
