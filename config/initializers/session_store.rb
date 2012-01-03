# Be sure to restart your server when you modify this file.

Canary::Application.config.session_store :cookie_store, key: '_canary_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Canary::Application.config.session_store :active_record_store

require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store :dalli_store,
                                        :memcache_server => ENV['MEMCACHE_SERVERS'].split(','),
                                        :namespace => 'sessions',
                                        :key => '_moodmetricsapp_session',
                                        :expire_after => 30.minutes
