local count = 10;
local function clearOneByLimit(key)
  count = count - 1
--  redis.log(redis.LOG_NOTICE, count)
  print(count)
  if count > 0 then
    return true
  else
    return
  end
end

--print(clearOneByLimit())


local function clearOne(key)
  while clearOneByLimit(key) do
    print();
  end
end

if {} then
  print('hhh')
end

--clearOne('xxx')

--function clearOne(hylandaId)
--  print(hylandaId)
--end
--
--local totalChange = 0
--
--totalChange += (false or 1)
--print(totalChange)

--clearOne('xxxxxxxxxxxx')


--local sha1 = require 'sha1'
--local hash_as_hex = sha1('xxx')
--print(hash_as_hex)

--print(type(a))   --> nil   (`a' is not initialized)
--a = 10
--print(type(a))   --> number
--a = "a string!!"
--print(type(a))   --> string
--a = print        -- yes, this is valid!
--a(type(a)) 
--
--a = {}
--print(type(a));
