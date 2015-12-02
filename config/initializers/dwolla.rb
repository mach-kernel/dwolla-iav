require 'dwolla_swagger'

module Dwolla
  DwollaSwagger::Swagger.configure do |config|
    config.access_token = 'p10WCLlInJwWtVWBraB4VANUVzD9dEJxItwVxM6fiHVkaHZNcD'
    config.host = 'api-uat.dwolla.com'
    config.base_path = '/'
    config.verify_ssl = false if Rails.env.development?
  end
end