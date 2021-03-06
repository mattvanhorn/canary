if ENV['TDDIUM']
  redis = YAML.load(ERB.new(File.read('config/redis.yml')).result)[Rails.env]
  REDIS = Redis.new(redis)

elsif ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

else
  REDIS = Redis.new

end