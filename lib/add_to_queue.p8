function add_to_queue(_func,_delay,_args)
 for _a in all(action_queue) do
  if _a.func == _func and _a.args == _args then
   _a.delay = _delay
  elseif _func == flash and _a.func == flash and _a.args[1] == _args[1] then
   _a.delay = _delay
   _a.args = _args
  end
 end
 add(
  action_queue,{
   func = _func,
   delay = _delay,
   args = _args
  }
 )
end

function reactivate(_r)
 _r.deactivated=false
end

function disable_bonus(_o)
 _o.bonus_enabled=false
 end_flash(_o,false)
end
