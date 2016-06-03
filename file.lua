--print('Hello World')
--print('Hello World')
function join(hash)
  local str = '';
  return str;
end

local hash = {a15=20, x23=18}
print(table.concat(hash, '*'))
-- for i,v in pairs(hash) do
--   print(i, v)
-- end

function join(hash)
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
print(join(hash));
