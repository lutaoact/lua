-- \redis-cli -h "${REDIS_ADDR//:6379}" -n "$REDIS_DB" --eval mergeTwoSet.lua 'archive:prefixes:part2:deleting' 'archive:prefixes:part4:deleting' 'archive:prefixes:part2:deleting:marker' 'archive:prefixes:part4:deleting:marker'

local keyFrom = KEYS[1]
local keyTo = KEYS[2]
local markerKeyFrom = KEYS[3]
local markerKeyTo = KEYS[4]

redis.log(redis.LOG_NOTICE, keyFrom, keyTo, markerKeyFrom, markerKeyTo)
redis.call('hmset', markerKeyTo, unpack(redis.call('hgetall', markerKeyFrom)))
redis.call('sunionstore', keyTo, keyFrom, keyTo)

redis.call('del', keyFrom)
redis.call('del', markerKeyFrom)

return 'finished success'
