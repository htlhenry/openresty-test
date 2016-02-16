local delay = 5
local shared = ngx.shared.dog
local dorun
dorun = function()
    local ok, err = ngx.timer.at(delay, dorun)
    if not ok then
      ngx.log(ngx.ERR, "failed to create the timer: ", err)
      return
    end
    ngx.log(ngx.ERR,"test 5 s log record")
    local value, flags = shared:get("test")
    if  value then
    local newval, err = shared:incr("test",1)
       if not newval then
           ngx.log(ngx.ERR, "[ incr test error : ] ", err)
       end
    else
       local succ, err, forcible = shared:set("test",0)
          if not succ then
              ngx.log(ngx.ERR,"shared:set test errror : ", err, "forcible : ", forcible)
          end
    end
end
local ok, err = ngx.timer.at(delay, dorun) 
--这个ngx.timer.at是在init_worker_by_lua*这个context里的，会在启动worker进程时启动一次，调用了ngx.timer.at这个方法，会在后台启动
--一个轻线程，然后当计时器过期的时候，会执行dorun这个callback函数，此时durun函数是在ngx.timer*这个context里，然后计时器到期后
--同样会在后台启动一个轻线程，然后调用dorun函数，而dorun这个函数又调用了ngx.timer.at这个lua函数，这样就又会在后台启动一个轻线程，
--执行一次dorun函数，以此类推，循环创建轻线程以及循环调用dorun函数，并销毁轻线程。
--ngx.log 在init_work_by_lua*这个context中，只会执行一次就结束。
ngx.log(ngx.ERR,"ok :",ok,"err :",err)
  if not ok then
     ngx.log(ngx.ERR, "failed to create the timer: ", err)
     return
  end