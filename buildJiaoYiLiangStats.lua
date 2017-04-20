-- \redis-cli -h mongo -n 6 --eval buildJiaoYiLiangStats.lua codeFirstTime tb:600000 jyls:600000 , 600000 1492669773 3.22 50
-- \redis-cli -h mongo -n 6 --eval buildJiaoYiLiangStats.lua codeFirstTime tb:600000 jyls:600000 , 600000 1492669779 3.23 50

-- 数据类型 codeFirstTime => hash, timeBits => bit, stats => zset
local codeFirstTime, timeBits, stats = unpack(KEYS)
local code, curTime, price, quantity = unpack(ARGV)

local firstTime = redis.call('hget', codeFirstTime, code)

local function saveFirst()
  redis.call('del', timeBits, stats)

  redis.call('hset', codeFirstTime, code, curTime)
  redis.call('setbit', timeBits, 0, 1)
  redis.call('zadd', stats, quantity, price)
end

if firstTime then
  firstTime = tonumber(firstTime)
  curTime   = tonumber(curTime)
  local diff = curTime - firstTime
  if diff > 6 * 3600 then
    redis.log(redis.LOG_NOTICE, 'another day', code, curTime, diff)

    saveFirst()
  else
    local bit = redis.call('setbit', timeBits, diff, 1)
    if bit == 0 then
      redis.call('zincrby', stats, quantity, price)
    end
  end
else
  redis.log(redis.LOG_NOTICE, 'no firstTime', code, curTime)
  saveFirst()
end

return ''
