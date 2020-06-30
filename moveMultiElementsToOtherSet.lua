local old_key = 'archive:prefixes:deleting'
local count = 50000

local elements = redis.call('smembers', 'archive:prefixes:deleting')
for i = 1, #elements do
  local ele = elements[i]
  local new_key = 'archive:prefixes:part'..(math.ceil(i/count))..':deleting'
  redis.log(redis.LOG_NOTICE, i, new_key, ele)
  redis.call('smove', old_key, new_key, ele)

  if i == (5 * count) then
    break
  end
end

return 'finished success'
