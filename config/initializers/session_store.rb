# Be sure to restart your server when you modify this file.
if Rails.env.production?
  require 'action_dispatch/middleware/session/dalli_store'
  Canary::Application.config.session_store :dalli_store,
                                            :memcache_server => ENV['MEMCACHE_SERVERS'].split(','),
                                            :namespace => 'sessions',
                                            :key => '_moodmetricsapp_session',
                                            :expire_after => 20.minutes
else
  Canary::Application.config.session_store :cookie_store, key: '_canary_session'
end
