local link_id = redis.call('incr', KEYS[1])
redis.call('hset', KEYS[2], link_id, ARGV[1])
return link_id
