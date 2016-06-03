local join = function(hash)
  local str = '';
  for i, v in pairs(hash) do
    local tmp = i .. '**' .. v
    if str == '' then
      str = tmp
    end
    str = str .. '##' .. tmp
  end
  return str;
end

--local result = {};
--local hostCountKeys = redis.call('keys', 'hostCount'.."*")
--local link;
--for index = 1, #hostCountKeys do
--  local hashKey = hostCountKeys[index]
--  local hash = redis.call('hgetall', hashKey);
--  result[hashKey] = join(hash)
--  redis.log(redis.LOG_NOTICE, "index: "..index..", hashKey: "..hashKey)
--  redis.log(redis.LOG_NOTICE, result[hashKey])
----  redis.call('del', hashKey)
--end
local hash = redis.call('hgetall', 'hostCount:20160603:456');
local str = table.concat(hash, '**');
redis.log(redis.LOG_NOTICE, str)
return str;
