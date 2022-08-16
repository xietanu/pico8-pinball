function init_targets()
 -- initialize targets
 skillshot_target=create_target(
   vec(42,7),
   gen_polygon("-1,0,2.5,0,2.5,2,-1,4"),
   vec(40,0),
   2,4
  )
 skillshot_target.p=nil
 skillshot_target.reset_timer=0
 skillshot_target.update=update_skillshot_target
 skillshot_target.check_collision=check_collision_with_skillshot
 add(static_colliders,skillshot_target)
 add(static_over,skillshot_target)
 add(to_update,skillshot_target)
 local left_col=gen_polygon(
  "0,-1,3,0,2,5,-1,5"
 )
 left_targets={
  elements={
   create_target(
    vec(12,76),
    left_col,
    vec(32,0),
    3,5
   ),
   create_target(
    vec(14,68),
    left_col,
    vec(32,0),
    3,5
   ),
   create_target(
    vec(16,60),
    left_col,
    vec(32,0),
    3,5
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
 _spr_w,
 _spr_h
)
 -- create a target
 return {
  origin=_origin,
  simple_collider=gen_simple_collider(_collider),
  check_collision=check_collision_with_target,
  collider=_collider,
  draw=draw_spr,
  hit=0,
  c=7,
  lit=false,
  complete=true,
  spr_coords=_unlit_spr,
  hit_spr_coords=_unlit_spr:plus(vec(_spr_w,0)),
  spr_off=vec(0,0),
  spr_w=_spr_w,
  spr_h=_spr_h,
  p=target_pnts
 }
end

function check_collision_with_target(_obj,_pin)
 -- action to take if pinball
 -- hits the target
 if check_collision_with_collider(_obj,_pin) then
  _obj.lit=true
  _obj.hit = 7
 end
end

function update_skillshot_target(_t)
 _t.reset_timer=max(0,_t.reset_timer-1)
 if _t.reset_timer%30>15 then
  _t.spr_i=_t.lit_spr
 else
  _t.spr_i=_t.unlit_spr
 end
end

function check_collision_with_skillshot(_t,_pin)
 if check_collision_with_collider(_t,_pin) then
  if _t.reset_timer > 0 then
   increase_score(skillshot_points,1)
   add(msgs,{"skillshot!",t=90})
   _t.reset_timer=0
   _t.hit = 7
  end
 end
end