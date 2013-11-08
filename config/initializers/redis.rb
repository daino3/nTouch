require 'redis'

$redis = Redis.new(:host => "localhost", :port => 6379)


# Event.today.all |event|
#   Job.queue << event
# end
