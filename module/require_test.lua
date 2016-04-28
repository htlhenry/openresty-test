--"lib"库必须是一个模块，何为一个模块，就是有一个全局的table空间保存模块内的变量。\
--注意，lib库需要放到package路径中。

--错误例子：
require 'lib'

--假设lib里有一个get函数
local val = get()

--此时第一次运行时没有问题，但是之后运行会报错，说获取不到get这个函数，得到的是一个nil值。

--正确例子：
local lib = require 'lib'

local var = lib.get()




