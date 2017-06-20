local mKeys = redis.call('keys', 'm:*')
for i = 1, #mKeys do
  local mKey = mKeys[i]
  -- 生成的key格式为erm:code
  local dstKey = 'er'..mKey
  redis.call('zinterstore', dstKey, 2, mKey, 'er2', 'weights', 0, 1)
  redis.log(redis.LOG_NOTICE, mKey, dstKey)
end

local now = redis.call('time')[1]
return 'finished '..now
