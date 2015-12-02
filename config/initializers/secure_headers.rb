SecureHeaders::Configuration.configure do |config|
  config.csp = {
    :default_src => "https: self",
    :script_src => "https: self",
    :img_src => "self",
    :tag_report_uri => true,
    :enforce => true,
    :app_name => 'secure_headers_test',
    :report_uri => '/csp_reports'
  }
end