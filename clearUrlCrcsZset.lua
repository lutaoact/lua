redis.replicate_commands() --3.2版本之后才新增的东西

local now = redis.call('time')[1]
local timestamp = tonumber(now) - 7 * 86400
--local timestamp = 1468319639
redis.log(redis.LOG_NOTICE, 'timestamp:', timestamp)

local function clearOneByLimit(hylandaId, key)
  local urlCrcs = redis.call(
    'zrangebyscore', key, '-inf', timestamp, 'limit', 0, 100
  )
  if next(urlCrcs) == nil then return end --空table的话直接返回

  local values = redis.call(
    'hmget', 'dpt:'..hylandaId..':goOnUpdateCount', unpack(urlCrcs)
  )
  local reducedCountChange = 0
  for i = 1, #values do
    if values[i] then
--      redis.log(redis.LOG_NOTICE, hylandaId, urlCrcs[i], values[i]) --调试
      reducedCountChange = reducedCountChange + tonumber(values[i])
    end
  end
  redis.call('hincrby', 'dpt:reducedCount', hylandaId, reducedCountChange)
  redis.call('hdel', 'dpt:'..hylandaId..':goOnUpdateCount', unpack(urlCrcs))
  redis.call('zrem', key, unpack(urlCrcs))
  return true
end

local function clearOne(key)
  local hylandaId = string.sub(key, 5, 18)
  redis.log(redis.LOG_NOTICE, hylandaId)
  local count = 0;
  while clearOneByLimit(hylandaId, key) do
    redis.log(redis.LOG_NOTICE, hylandaId, count)
    count = count + 1
  end
end

local cursor = '0'
repeat
  local result = redis.call(
    'scan', cursor, 'match', 'dpt:*:urlCrcs', 'count', 100
  )
  cursor = result[1]
  local urlCrcsKeys = result[2]
  for i = 1, #urlCrcsKeys do
    local key = urlCrcsKeys[i]
    clearOne(key)
  end
until (cursor == '0')

return 'finished '..now..', 7 days ago '..timestamp
