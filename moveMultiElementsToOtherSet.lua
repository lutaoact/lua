redis.replicate_commands() --3.2版本之后才新增的东西

local count = 0
local old_key = 'archive:prefixes:deleting'
local new_key = 'archive:prefixes:part1:deleting'
local cursor = '0'
repeat
  local result = redis.call(
    'sscan', old_key, cursor, 'count', 10000
  )
  cursor     = result[1]
  local elements = result[2]

  for i = 1, #elements do
    local ele = elements[i]
    redis.log(redis.LOG_NOTICE, ele)
    redis.call('smove', old_key, new_key, ele)
  end
  count = count + 1
until (cursor == '0' or count >= 10) -- cursor != 0 && count < 3 的时候执行循环

return 'finished success'
