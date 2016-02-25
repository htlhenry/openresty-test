function table.removeKey(t, k_to_remove)
  local new = {}
  for k, v in pairs(t) do
    new[k] = v
  end
  new[k_to_remove] = nil
  return new
end
t = {aa = 1, bb = 2}

table.remoteKey(t, bb)
ngx.say(t)
