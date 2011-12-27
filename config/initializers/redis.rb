if ENV['TDDIUM']
  redis = YAML.load(ERB.new(File.read('config/redis.yml')).result)[Rails.env]
  REDIS = Redis.new(redis)
elsif Rails.env == "production" || Rails.env == "staging"
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)  
else
  REDIS = Redis.new
end