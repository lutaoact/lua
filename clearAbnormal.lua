-- \redis-cli -h mongo -n 2 --eval clearAbnormal.lua

redis.replicate_commands() --3.2版本之后才新增的东西

local cursor = '0'
repeat
  local result = redis.call(
    'scan', cursor, 'match', 'abnormal:*', 'count', 100
  )
  cursor = result[1]
  local list = result[2]
  redis.log(redis.LOG_NOTICE, table.concat(list, ','))
  redis.call('del', unpack(list))
until (cursor == '0')
