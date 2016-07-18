redis.replicate_commands() --3.2版本之后才新增的东西

local timestamp = tonumber(redis.call('time')[1]) - 7 * 86400
redis.log(redis.LOG_NOTICE, 'timestamp:', timestamp)

local function clearOne(key)
  local hylandaId = string.sub(key, 5, 18)
  redis.log(redis.LOG_NOTICE, hylandaId)
  local urlCrcs = redis.call('zrangebyscore', key, '-inf', timestamp)
  if next(urlCrcs) == nil then return end --空table的话直接返回

  local values = redis.call(
    'hmget', 'dpt:'..hylandaId..':goOnUpdateCount', unpack(urlCrcs)
  )
  local reducedCountChange = 0
  for i = 1, #values do
    if values[i] then
      reducedCountChange = reducedCountChange + tonumber(values[i])
    end
  end
  redis.log(redis.LOG_NOTICE, hylandaId, reducedCountChange)
  redis.call('hincrby', 'dpt:reducedCount', hylandaId, reducedCountChange)
  redis.call('hdel', 'dpt:'..hylandaId..':goOnUpdateCount', unpack(urlCrcs))
  redis.call('zremrangebyscore', key, '-inf', timestamp)
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
    redis.log(redis.LOG_NOTICE, key)
    clearOne(key)
  end
until (cursor == '0')
