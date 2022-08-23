function init_targets()
 -- initialize targets
 skillshot_target=create_target(
  vec(24,13),
  gen_polygon("-1,-0.5,2.5,0.5,2.5,4,-1,4"),
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
    vec(13,70),
    left_col,
    vec(32,0),
    3,5
   ),
   create_target(
    vec(14,63),
    left_col,
    vec(32,0),
    3,5
   ),
  },
  all_lit_action=left_targets_lit
 }
 add_target_group_to_board(left_targets)

 right_target_poly = gen_polygon(
  "3,5,1.5,5,-0.5,1,1,-1"
 )

 right_targets={
  elements={
   create_target(
    vec(55,50),
    right_target_poly,
    vec(42,18),
    3,5
   ),
   create_target(
    vec(64,74),
    right_target_poly,
    vec(42,18),
    3,5
   )
  },
  all_lit_action=right_targets_lit
 }
 add_target_group_to_board(right_targets)

 h_target_poly = gen_polygon(
  "-1,-1,5,-1,4,3,-1,2"
 )

 rocket_targets={
  elements={
   create_target(
    vec(38,61),
    h_target_poly,
    vec(0,48),
    5,3
   ),
   create_target(
    vec(32,60),
    h_target_poly,
    vec(0,48),
    5,3
   )
  },
  all_lit_action=pass
 }
 add_target_group_to_board(rocket_targets)
 
end

function add_target_group_to_board(_grp,_draw_layer)
 for _t in all(_grp.elements) do
  _t.group = _grp
  add(static_colliders,_t)
  add(_draw_layer or static_over,_t)
 end
end

function create_target(
 _origin,
 _collider,
 _unlit_spr,
 _spr_w,
 _spr_h
)
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
  if _obj.group then
   group_elem_lit(_obj.group)
  end
 end
end

function update_skillshot_target(_t)
 _t.reset_timer=max(0,_t.reset_timer-1)
 if _t.reset_timer%30>15 then
  _t.lit=true
 else
  _t.lit=false
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

function left_targets_lit(_g)
 reset_drain(left_drain)
 rollovers_all_lit(_g)
end

function right_targets_lit(_g)
 reset_drain(right_drain)
 rollovers_all_lit(_g)
end
