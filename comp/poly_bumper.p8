function init_poly_bumpers()
 -- create polyginal bumpers
 spaceship = create_poly_bumper(
  vec(29,55),
  {
   vec(-1,3,1,250),
   vec(6,0,1,250),
   vec(17,-1),
   vec(14,2),
   vec(14,4),
   vec(17,7),
   vec(6,6)
  },
  vec(0,48),
  16,7,
  false,
  vec(32,48)
 )

 local _wall_col = gen_polygon("75,27,72,34")
 launch_block={
  origin=vec(0.5,0.5),
  collider=_wall_col,
  simple_collider=gen_simple_collider(_wall_col),
  check_collision=check_collision_with_collider
 }


 left_drain_block = create_poly_bumper(
  vec(16.5,110.5),
  gen_polygon("-1,-5,-1,6"),
  vec(36,5),
  1,3
 )
 right_drain_block = create_poly_bumper(
  vec(63.5,110.5),
  gen_polygon("1,-5,1,6"),
  vec(36,5),
  1,3
 )
 add(always_colliders,left_drain_block)
 add(static_over,left_drain_block)
 add(always_colliders,right_drain_block)
 add(static_over,right_drain_block)

 left_drain = create_poly_bumper(
  vec(13,112),
  {
   vec(0,-1),
   vec(2,1)
  },
  vec(32,5),
  3,4,
  true
 )
 left_drain.light = left_drain_light
 left_drain.block = left_drain_block

 right_drain = create_poly_bumper(
  vec(64,112),
  {
   vec(2,-1),
   vec(0,1)
  },
  vec(32,5),
  3,4,
  false
 )
 right_drain.light = right_drain_light
 right_drain.block = right_drain_block

 
 
 poly_bumpers={
   -- spaceship
   spaceship,
   -- left bumper
   create_poly_bumper(
    vec(51,95),
    gen_polygon("4,-1,6,1,6,11,1,14,-1,13,2,1"),
    vec(8,0),
    8,14,
    false,
    vec(40,4)
   ),
   -- right bumper
   create_poly_bumper(
    vec(21,95),
    gen_polygon("5,1,8,13,6,14,1,11,1,1,3,-1"),
    vec(8,0),
    8,14,
    true,
    vec(40,4)
   ),
   -- right gutter pin
   create_poly_bumper(
    vec(64.5,120),
    {
     vec(0,0,2.1,0,true),
     vec(2,0)
    },
    vec(43,0),
    3,2,
    false,
    nil,
    close_right_drain
   ),
   -- left gutter pin
   create_poly_bumper(
    vec(13.5,120),
    {
     vec(0,0,2.1,0,true),
     vec(2,0)
    },
    vec(43,0),
    3,2,
    false,
    nil,
    close_left_drain
   )
 }
 poly_bumpers[2].collider[5] = vec(-1,13,1,250,false,13)
 poly_bumpers[3].collider[1] = vec(5,1,1,250,false,13)

 add_group_to_board(poly_bumpers,{static_colliders,static_over})
end

function create_poly_bumper(
 _origin,
 _collider,
 _spr,
 _spr_w,
 _spr_h,
 _flip_x,
 _spr_hit_coords,
 _action
)
 -- create a polyginal bumper
 _spr_w,_spr_h=_spr_w or 1,_spr_h or 1
 return {
  origin=_origin,
  simple_collider=gen_simple_collider(_collider),
  collider=_collider,
  spr_off=vec(0,0),
  spr_coords=_spr,
  hit_spr_coords=_spr_hit_coords,
  r=4,
  draw=draw_spr,
  check_collision=check_collision_with_collider,
  spr_w=_spr_w,
  spr_h=_spr_h,
  flip_x=_flip_x,
  complete=true,
  hit=0,
  c=7,
  action=_action
 }
end

function close_left_drain()
 reset_drain(left_drain)
 add_to_queue(close_drain,30,{left_drain})
end

function close_right_drain()
 reset_drain(right_drain)
 add_to_queue(close_drain,30,{right_drain})
end

function close_drain(
 _d
)
 if _d.light.lit then
  add(static_over,_d)
  add(always_colliders,_d)
  del(static_over,_d.block)
  del(always_colliders,_d.block)
  _d.light.lit = false
 end
end

function reset_drain(_d)
 if not _d.light.lit then
  del(static_over,_d)
  del(always_colliders,_d)
  add(static_over,_d.block)
  add(always_colliders,_d.block)
  _d.light.lit = true
 end
end
