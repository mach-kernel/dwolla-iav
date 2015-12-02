require 'dwolla_swagger'

module Dwolla
  DwollaSwagger::Swagger.configure do |config|
    config.access_token = 'HcFb6DMNZvFyeW5hS9bQnbXrUaTmg0ifdGlbeNO7I6AfS4dquG'
    config.host = 'api-uat.dwolla.com'
    config.base_path = '/'
    config.verify_ssl = false if Rails.env.development?
  end
end