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
  vec(0,64),
  16,7,
  false,
  vec(0,71)
 )

 launch_block=init_wall(
  gen_polygon("75,27,72,34")
 )

 left_drain_block = create_poly_bumper(
  vec(16,110),
  gen_polygon("-1,-4,-1,5"),
  vec(36,5),
  1,3
 )
 right_drain_block = create_poly_bumper(
  vec(63,110),
  gen_polygon("1,-4,1,5"),
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

 local narrow_wall_col=gen_polygon(
  "0,-1,1,0,1,3,0,4,-1,3,-1,0"
 )
 
 poly_bumpers={
   -- spaceship
   spaceship,
   -- left bumper
   create_poly_bumper(
    vec(51,95),
    {
     vec(4,-1),
     vec(6,1),
     vec(6,11),
     vec(1,14),
     vec(-1,13,1,250),
     vec(2,1)
    },
    vec(8,0),
    8,14,
    false,
    vec(40,4)
   ),
   -- right bumper
   create_poly_bumper(
    vec(21,95),
    {
     vec(5,1,1,250),
     vec(8,13),
     vec(6,14),
     vec(1,11),
     vec(1,1),
     vec(3,-1)
    },
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
 for _o in all({vec(31,15),vec(37,15),vec(43,15),vec(49,15)}) do
  add(
   poly_bumpers,
   init_wall(
    narrow_wall_col,
    true,
    _o
   )
  )
 end
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
