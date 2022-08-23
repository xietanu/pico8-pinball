function group_elem_lit(_grp)
 if _grp.deactivated then
  return
 end
 for _r in all(_grp.elements) do
  if not _r.lit then
   return
  end
 end
 for _r in all(_grp.elements) do
  flash(_r,2,false)
 end

 _grp.deactivated = true
 add_to_queue(reactivate,65,{_grp})

 _grp:all_lit_action()
end

function shift_light_left(_r)
 -- shift lit status to the left
 local _first_l = _r[1].lit
 for i=2,#_r do
  set_light(_r[i-1],_r[i].lit)
 end
 set_light(_r[#_r],_first_l)
end

function shift_light_right(_r)
 -- shift lit status to the right
 local _last_l = _r[#_r].lit
 for i=0,#_r-2 do
  set_light(_r[#_r-i],_r[#_r-i-1].lit)
 end
 set_light(_r[1],_last_l)
end

function add_group_to_board(_grp,_layers)
 for _el in all(_grp) do
  for _l in all(_layers) do
   add(_l,_el)
  end
 end
end
