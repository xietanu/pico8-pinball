function flash(_o,_times,_next_state,_rep_call)
 -- Will end on initialitial _next_state
 if not _o then
  return
 elseif not(_rep_call) then
  _o.flashing = true
 elseif not _o.flashing then
  return
 end

 set_light(_o,_next_state)

 if _times <= 0 and _times > -99 then
  _o.flashing = false
  return
 end

 _times -= 0.5
 add_to_queue(flash,15,{_o,_times,not _next_state, true})
end

function end_flash(_o,_state)
 _o.flashing = false
 set_light(_o,_state)
end
