function group_elem_lit(_grp)
 if _grp.deactivated then
  return
 end
 for _r in all(_grp.elements) do
  if not _r.lit then
   return
  end
 end
 sfx(_grp.sfx)

 flash_table(_grp.elements,2,false)

 _grp.deactivated = true
 add_to_queue(reactivate,65,{_grp})

 _grp:all_lit_action()
end

function shift_light_left(_r)
 -- shift lit status to the left
 shift_light(_r,-1)
end

function shift_light(_r,_dir)
 local _cpy={}
 for i in all(_r) do
  add(_cpy,i.lit or false)
 end
 for i = 1,#_r do
  set_light(_r[mod(i+_dir,#_r)],_cpy[i])
 end
end

function shift_light_right(_r)
 -- shift lit status to the right
 shift_light(_r,1)
end

function add_group_to_board(_grp,_layers)
 for _el in all(_grp) do
  for _l in all(_layers) do
   add(_l,_el)
  end
 end
end
