function init_targets()
 -- initialize targets
 local left_col=gen_polygon(
    "0,-1,3,0,2,5,-1,5"
   )
 left_targets={
  elements={
   create_target(
    vec(12,76),
    left_col,
    5,
    21
   ),
   create_target(
    vec(14,68),
    left_col,
    5,
    21
   ),
   create_target(
    vec(16,60),
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
 -- create a target
 -- args:
 -- _origin (vector): anchor point
 -- _collider (table): list of
 --  vertices defining outside
 -- _unlit_spr (int): sprite
 --  index for unlit sprite
 -- _lit_spr (int): sprite
 --  index for lit sprite
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
 -- action to take if pinball
 -- hits the target
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
