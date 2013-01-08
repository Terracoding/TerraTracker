Airbrake.configure do |config|
  config.api_key = 'fa139ba40c7fb8af3de1d9e7fb83c02c'
  config.host    = 'errbit.domness.me'
  config.port    = 80
  config.secure  = config.port == 443
end
