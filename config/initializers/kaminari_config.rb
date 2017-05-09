Kaminari.configure do |config|
  config.default_per_page = 3
  config.window = 2
  config.param_name = 'q[page]'
end
