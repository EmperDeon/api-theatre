# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

require 'jwt/json_web_token'

Mime::Type.register 'application/pdf', :pdf
Mime::Type.register 'image/png', :png