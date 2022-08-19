function update_elem_group(_grp)
 -- update element group each
 -- frame.
 if _grp.rotatable then
  if btnp(⬅️) then
   shift_light_left(_grp.elements)
  end
  if btnp(➡️) then
   shift_light_right(_grp.elements)
  end
 end
end

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
 -- args:
 -- _r (table): the element
 --  group.
 local _first_l = _r[1].lit
 for i=2,#_r do
  set_light(_r[i-1],_r[i].lit)
 end
 set_light(_r[#_r],_first_l)
end

function shift_light_right(_r)
 -- shift lit status to the right
 -- args:
 -- _r (table): the element
 --  group.
 local _last_l = _r[#_r].lit
 for i=0,#_r-2 do
  set_light(_r[#_r-i],_r[#_r-i-1].lit)
 end
 set_light(_r[1],_last_l)
end