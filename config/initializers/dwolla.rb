require 'dwolla_swagger'

module Dwolla
  DwollaSwagger::Swagger.configure do |config|
    config.access_token = '2tQZD5TdOZkMVNRxqPgPeCL4o88CgZklNCYqcr9jDl35NwBuTM'
    config.host = 'api-uat.dwolla.com'
    config.base_path = '/'
    config.verify_ssl = false if Rails.env.development?
  end
end