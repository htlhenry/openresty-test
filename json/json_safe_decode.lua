
--cjson 2.1.0 该版本新增一个cjson.safe模块接口，该接口兼容cjson模块，并且在解析错误时不抛出异常，而是返回nil。

local json = require("cjson.safe")
local str = [[{"key":"value"}]]


local t = json.decode(str)
if t then
     ngx.say(" t ==>  ", type(t))
     for k, v in pairs(t) do 
         ngx.say("k : ", k, "  v : ", v)
     end
end


--ipairs()用于遍历数组（索引表），pairs()用于遍历table型元素（哈希表）
--值得一提是，在 LuaJIT 2.1 中，ipairs() 内建函数是可以被 JIT 编译的，而 pairs() 则只能被解释执行。
--因此在性能敏感的场景，应当合理安排数据结构，避免对哈希表进行遍历。 （事实上，即使未来 pairs 可以被 JIT 编译，
--哈希表的遍历本身也不会有数组遍历那么高效，毕竟哈希表 就不是为遍历而设计的数据结构。）


--如果需要在Lua中处理错误，必须使用函数pcall（protected call）来包装需要执行的代码。 
--pcall接收一个函数和要传递给后者的参数，并执行，执行结果：有错误、无错误；返回值true或者或false, errorinfo。
--pcall以一种"保护模式"来调用第一个参数，因此pcall可以捕获函数执行中的任何错误。

local json = require("cjson")


function json_decode( str )
    local json_value = nil
    pcall(function( str ) json_value = json.decode(str) end, str)
    return json_value
end

--稀疏数组
local json = require("cjson")


local t = {1,2}
t[1000] = 99


ngx.say(json.encode(t))  --此行代码会在运行是报错，[error] 9693#9693: *115048 lua entry thread aborted: 
--runtime error: ...a/soft/openresty_V1.9.7.3/nginx/conf/lua/common/json.lua:6: Cannot serialise table: 
--excessively sparse array 太稀疏的数组。
--为什么下标是1000就失败呢？实际上这么做是cjson想保护你的内存资源。她担心这个下标过大直接撑爆内存（贴心小棉袄啊）。
--如果我们一定要让这种情况下可以decode，就要尝试encode_sparse_array api了。有兴趣的同学可以自己试一试。
--我相信你看过有关cjson的代码后，就知道cjson的一个简单危险防范应该是怎样完成的。


--空table编码为array或者object

-- 内容节选lua-cjson-2.1.0.2/tests/agentzh.t
=== TEST 1: empty tables as objects
--- lua
local cjson = require "cjson"
print(cjson.encode({}))
print(cjson.encode({dogs = {}}))
--- out
{}
{"dogs":{}}


=== TEST 2: empty tables as arrays
--- lua
local cjson = require "cjson"
cjson.encode_empty_table_as_object(false)
print(cjson.encode({}))
print(cjson.encode({dogs = {}}))
--- out
[]
{"dogs":[]}


















