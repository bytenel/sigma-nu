SigmaNew::Application.configure do
 config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = true

  config.assets.compress = true
  config.assets.compile = false

  config.assets.digest = true
  config.assets.initialize_on_precompile = false
end
