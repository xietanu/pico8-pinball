function init_targets()
 -- initialize targets
 skillshot_target=create_target(
  vec(24.5,13.5),
  gen_polygon("-1,-0.5,2.5,0.5,2.5,4,-1,4"),
  nil,
  vec(40,0),
  2,4
 )
 skillshot_target.p=nil
 skillshot_target.sfx=nil
 skillshot_target.check_collision=check_collision_with_skillshot
 add(static_colliders,skillshot_target)
 add(static_over,skillshot_target)
 local left_col=gen_polygon(
  "0,-1,3,0,2,5,-1,5"
 )
 left_light_offset=vec(4,3)
 left_targets={
  elements={
   create_target(
    vec(12.5,76.5),
    left_col,
    left_light_offset,
    vec(32,0),
    3,5
   ),
   create_target(
    vec(13.5,70.5),
    left_col,
    left_light_offset,
    vec(32,0),
    3,5
   ),
   create_target(
    vec(15.5,63.5),
    left_col,
    left_light_offset,
    vec(32,0),
    3,5
   ),
  },
  all_lit_action=left_targets_lit,
  sfx=15
 }
 add_target_group_to_board(left_targets)

 right_target_poly = gen_polygon(
  "3,5,1.5,5,-0.5,1,1,-1"
 )
 right_light_offset = vec(-3,3)

 right_targets={
  elements={
   create_target(
    vec(53.5,47.5),
    right_target_poly,
    right_light_offset,
    vec(42,18),
    3,5
   ),
   create_target(
    vec(64.5,74.5),
    right_target_poly,
    right_light_offset,
    vec(42,18),
    3,5
   )
  },
  all_lit_action=right_targets_lit,
  sfx=15
 }
 add_target_group_to_board(right_targets)

 h_target_poly = gen_polygon(
  "-1,-1,5,-1,4,3,-1,2"
 )
 h_light_offset = vec(0,4)

 rocket_targets={
  elements={
   create_target(
    vec(38.5,61.5),
    h_target_poly,
    h_light_offset,
    vec(32,18),
    5,3
   ),
   create_target(
    vec(32.5,60.5),
    h_target_poly,
    h_light_offset,
    vec(32,18),
    5,3
   )
  },
  all_lit_action=pass,
  sfx=15
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
 _light_offset,
 _unlit_spr,
 _spr_w,
 _spr_h
)
 local _l = {
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
  p=1212,
  sfx=14
 }
 if _light_offset then
  _l.light = create_light(
   _origin:plus(_light_offset),
   nil,
   draw_dot_light
  )
  add(static_under,_l.light)
 end
 return _l
end

function check_collision_with_target(_obj,_pin)
 -- action to take if pinball
 -- hits the target
 if check_collision_with_collider(_obj,_pin) then
  _obj.lit=true
  if _obj.group then
   group_elem_lit(_obj.group)
  end
  if _obj.light.flashing then
   target_hunt_cnt += 1
   update_prog_light_group(pent_lights,target_hunt_cnt)
   add_to_queue(end_target_hunt,1800,{true})
   if target_hunt_cnt>=5 then
    end_target_hunt()
    increase_score(500,1)
    light_orbit(5)
    cycle_lights(pent_lights,1,3,10,true)
   else
    repeat
     flash_rnd_target()
    until cur_target != _obj
   end
  end
 end
end

function check_collision_with_skillshot(_t,_pin)
 if check_collision_with_collider(_t,_pin) and _t.bonus_enabled then
  increase_score(250,1)
  add(msgs,{"skillshot!",t=90})
  disable_bonus(_t)
  _t.hit = 7
  sfx(10)
 end
end

function left_targets_lit(_g)
 reset_drain(left_drain)
 rollovers_all_lit(_g)
 sfx(15)
end

function right_targets_lit(_g)
 reset_drain(right_drain)
 rollovers_all_lit(_g)
 sfx(15)
end
