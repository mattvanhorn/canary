
if Rails.env == "production" || Rails.env == "staging"
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)  
else
  REDIS = Redis.new
end