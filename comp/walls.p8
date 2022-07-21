function init_walls()
 -- initialize outer walls
 local narrow_wall_col=gen_polygon(
  "0,-1,1,0,1,3,0,4,-1,3,-1,0"
 )

 launch_block=init_wall(
  gen_polygon("75,27,72,34")
 )

 walls={
  init_wall(
   narrow_wall_col,
   true,
   vec(25,21)
  ),
  init_wall(
   narrow_wall_col,
   true,
   vec(31,17)
  ),
  init_wall(
   narrow_wall_col,
   true,
   vec(37,16)
  ),
  init_wall(
   narrow_wall_col,
   true,
   vec(43,16)
  ),
  init_wall(
   narrow_wall_col,
   true,
   vec(49,17)
  ),
  init_wall(
   narrow_wall_col,
   true,
   vec(55,21)
  ),
  -- inner curve top
  init_wall(
   gen_polygon(
    "21,18,26,13,32,9,38,9,42,11,42,7,35,6,29,8,19,16"
   )
  ),
  -- inner curve bottom
  init_wall(
   gen_polygon("21,18,18,24,18,32,21,44,18,41,15,32,15,23,19,16")

  ),
  init_wall(
   gen_polygon("49,128,64,113")
  ),
  init_wall(
   gen_polygon("63,85,66,88,66,119,65,121,64,119,64,113")
  ),
  init_wall(
   gen_polygon("50,45,50,49,62,61,68,57,69,58,63,70,67,81,63,85")
  ),
  init_wall(
   gen_polygon("72,34,67,39,50,45")
  ),
  init_wall(
   gen_polygon("36,1,43,1,54,2,64,7,71,14,75,22,75,27")
  ),
  init_wall(
   gen_polygon("13,12,17,8,25,3,36,1")
  ),
  init_wall(
   gen_polygon("14,49,14,48,10,36,9,29,9,25,10,17,13,12")
  ),
  init_wall(
   gen_polygon("14,49,9,52,8,53,9,54,17,56,12,81,16,85")
  ),
  init_wall(
   gen_polygon("16,85,13,88,13,118,14,121,15,118,15,113")
  ),
  init_wall(
   gen_polygon("15,113,30,128")
  ),
  init_wall(
   gen_polygon("29,118,15,106,15,93,16,92,18,94,18,106,31,117.5"),
   true
  ),
  init_wall(
   gen_polygon("50,118,64,106,64,93,63,92,61,94,61,106,48,117.5"),
   true
  ),
  init_wall(
   gen_polygon("64,106,64,113")
  ),
  init_wall(
   gen_polygon("15,106,15,113")
  )
  
 }
 for wall in all(walls) do
  add(static_colliders,wall)
  add(static_over,wall)
 end
end

function init_wall(
 _collider,
 _complete,
 _origin
)
 -- create a wall
 -- args:
 -- _collider (table): list of
 --  vertices defining outer edge
 -- _complete (bool): if the
 --  points form a complete
 --  polygon or just a line
 -- _origin (vector): anchor
 --  point for the wall.
 --  defaults to (0,0)
_origin=_origin or vec(0,0)
return {
  draw=draw_wall,
  origin=_origin,
  collider=_collider,
  simple_collider=gen_simple_collider(_collider),
  check_collision=check_collision_with_collider,
  c=7,
  complete=_complete
 }
end

function draw_wall(wall)
 if draw_outlines then
  draw_collider(wall)
 end
end
