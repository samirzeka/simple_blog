# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simple_blog_session',
  :secret      => '997c92e00274eb5cfebc486103e0238958a7b099c97c4a77b9f7434cbb5928e817d5549e2b9e3a3ddd60ea43d4ef4e5de807ceb0dc4913a4f39f202227e7f8ba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
