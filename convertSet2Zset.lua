local timestamp = ARGV[1] --取出服务器时间的秒时间戳

local keys = redis.call('keys', '*:urlCrcs')
for i = 1, #keys do
  local key = keys[i]
  local beforeType = redis.call('type', key)['ok']
  redis.log(redis.LOG_NOTICE, key, 'before:', beforeType)
  redis.call(
    'zunionstore', key, 1,
    key,
    'weights', timestamp,
    'aggregate', 'sum'
  )
  local afterType = redis.call('type', key)['ok']
  redis.log(redis.LOG_NOTICE, key, 'after:', afterType)
end
