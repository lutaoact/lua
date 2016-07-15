local key = 'dpt:10731077871588:urlCrcs'
local id = string.sub(key, 5, 18)
print(id)

--string.sub (s, i [, j])
--Returns the substring of s that starts at i and continues until j; i and j can be negative. If j is absent, then it is assumed to be equal to -1 (which is the same as the string length). In particular, the call string.sub(s,1,j) returns a prefix of s with length j, and string.sub(s, -i) returns a suffix of s with length i.
