function init_poly_bumpers()
 -- create polyginal bumpers
 poly_bumpers={
   -- spaceship
   create_poly_bumper(
    vec(40,60),
    gen_polygon("0,-4,3,3,4,15,1,12,-1,12,-4,15,-3,3"),
    96,
    1,2,
    false,
    vec(-3,-2)
   ),
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
    1,
    1,2
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
    1,
    1,2,
    true
   ),
   -- left gutter pin
   create_poly_bumper(
    vec(64,120),
    {
     vec(0,0,2.1,0,true),
     vec(2,0)
    },
    4
   ),
   -- right gutter pin
   create_poly_bumper(
    vec(13,120),
    {
     vec(0,0,2.1,0,true),
     vec(2,0)
    },
    4
   )
 }
 for _pb in all(poly_bumpers) do
  add(static_colliders,_pb)
  add(static_over,_pb)
 end
end

function create_poly_bumper(
 _origin,_collider,
 _spr_i,
 _spr_w,
 _spr_h,
 _flip_x,
 _spr_off
)
 -- create a polyginal bumper
 _spr_w,_spr_h=_spr_w or 1,_spr_h or 1
 _spr_off=_spr_off or vec(0,0)
 return {
  origin=_origin,
  simple_collider=gen_simple_collider(_collider),
  collider=_collider,
  spr_off=_spr_off,
  spr_i=_spr_i,
  r=4,
  draw=draw_spr,
  check_collision=check_collision_with_collider,
  spr_w=_spr_w,
  spr_h=_spr_h,
  flip_x=_flip_x,
  complete=true,
  c=7
 }
end
