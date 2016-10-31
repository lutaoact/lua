redis.replicate_commands() --3.2版本之后才新增的东西

local cursor = '0'
repeat
  local result = redis.call(
    'scan', cursor, 'match', 'abnormal:*:99', 'count', 100
  )
  cursor     = result[1]
  local keys = result[2]

  for i = 1, #keys do
    local key = keys[i]
    redis.log(redis.LOG_NOTICE, key)
    redis.call('del', key)
  end
until (cursor == '0')

return 'finished success, for detail: tail -f redis.log'
