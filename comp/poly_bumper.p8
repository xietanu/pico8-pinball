function init_poly_bumpers()
 -- create polyginal bumpers
 poly_bumpers={
   -- spaceship
   create_poly_bumper(
    vec(40,60),
    {
     {x=0,y=-4},
     {x=3,y=3},
     {x=4,y=15},
     {x=1,y=12},
     {x=-1,y=12},
     {x=-4,y=15},
     {x=-3,y=3},
    },
    96,
    1,2,
    false,
    vec(-3,-2)
   ),
   -- left bumper
   create_poly_bumper(
    {x=51,y=95},
    {
     {x=4,y=-1},
     {x=6,y=2},
     {x=6,y=11},
     {x=1,y=14},
     {x=-1,y=13,ref_spd=1.25,p=250},
     {x=2,y=2}
    },
    1,
    1,2
   ),
   -- right bumper
   create_poly_bumper(
    {x=21,y=95},
    {
     {x=5,y=2,ref_spd=1.25,p=1000},
     {x=8,y=13},
     {x=6,y=14},
     {x=1,y=11},
     {x=1,y=2},
     {x=3,y=-1}
    },
    1,
    1,2,
    true
   ),
   -- left gutter pin
   create_poly_bumper(
    {x=64,y=120},
    {
     {x=0,y=0,ref_spd=2.25,only_ref=true},
     {x=2,y=0}
    },
    4
   ),
   -- right gutter pin
   create_poly_bumper(
    {x=13,y=120},
    {
     {x=0,y=0,ref_spd=2.25,only_ref=true},
     {x=2,y=0}
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
 -- args:
 -- _origin (vector): anchor
 --  point for the bumper.
 -- _collider (table): list of
 --  vertices defining outside
 -- _spr_i (int): sprite index
 -- _spr_w (int): width of
 --  sprite (defaults to 1)
 -- _spr_h (int): height of
 --  sprite (defaults to 1)
 -- _flip_x (bool): whether to
 --  flip the sprite (defaults
 --  to false)
 -- _spr_off (vector): offset
 --  from the origin to start
 --  drawing the sprite.
 --  defaults to (0,0)
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
