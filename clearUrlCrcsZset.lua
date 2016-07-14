--local timestamp = ARGV[1] --取出服务器时间的秒时间戳

local cursor = 0
repeat
  local result = redis.call(
    'scan', cursor, 'match', 'dpt:*:urlCrcs', 'count', 100
  )
  cursor = tonumber(result[1])
  redis.log(redis.LOG_NOTICE, type(cursor))
  local urlCrcsKeys = result[2]
  for i = 1, #urlCrcsKeys do
    local key = urlCrcsKeys[i]
    redis.log(redis.LOG_NOTICE, key, type(key))
  end
until (cursor == 0)
