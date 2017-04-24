-- \redis-cli -h mongo -n 0 --eval migrateUserAccessToken.lua

redis.replicate_commands()

local now = redis.call('time')[1]
local timestamp = tonumber(now) * 1000

local tokenKeys = redis.call('keys', 'common:*')
for i = 1, #tokenKeys do
  local tokenKey = tokenKeys[i]
  local uid = string.sub(tokenKey, 8, 31)
  local token = redis.call('hget', tokenKey, 'access')
  redis.call('zadd', 'tk:'..uid, timestamp, token)
  redis.log(redis.LOG_NOTICE, 'zadd', 'tk:'..uid, timestamp, token)
end

return 'finished '..now
