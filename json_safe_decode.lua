
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