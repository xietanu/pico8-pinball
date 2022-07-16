function init_targets()
 local left_col={
    {x=0,y=-1},
    {x=3,y=0},
    {x=2,y=5},
    {x=-1,y=5}
   }
 left_targets={
  elements={
   create_target(
    {x=12,y=76},
    left_col,
    5,
    21
   ),
   create_target(
    {x=14,y=68},
    left_col,
    5,
    21
   ),
   create_target(
    {x=16,y=60},
    left_col,
    5,
    21
   ),
   
  },
  update=update_elem_group,
   all_lit_action=rollovers_all_lit,
   flash=0
 }
 for _t in all(left_targets.elements) do
  add(static_colliders,_t)
  add(static_over,_t)
 end
 add(to_update,left_targets)
end

function create_target(
 _origin,
 _collider,
 _unlit_spr,
 _lit_spr
)
 return {
  origin=_origin,
  simple_collider=gen_simple_collider(_collider),
  check_collision=check_collision_with_target,
  collider=_collider,
  draw=draw_spr,
  c=7,
  lit=false,
  complete=true,
  unlit_spr=_unlit_spr,
  lit_spr=_lit_spr,
  spr_i=_unlit_spr,
  spr_off={x=0,y=0}
 }
end

function check_collision_with_target(_obj,_pin)
 if check_collision_with_collider(_obj,_pin) then
  if _obj.lit then
   add_to_long(score,200)
  else
   add_to_long(score,500)
   _obj.lit=true
   _obj.spr_i=_obj.lit_spr
  end
 end
end
