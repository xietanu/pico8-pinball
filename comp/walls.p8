function init_walls()
 -- initialize outer walls

 wall_groups = {
  --right side
  "50,127,64,113,64,119,65,122,66,119,66,88,63,85,67,81,63,70,69,60,69,57,67,57,62,61,53,47,53,46,56,43,62,41,68,38,72,34",
  --left/top side
  "75,27,75,21,71,14,64,7,54,2,48,1,34,1,26,3,18,7,13,12,10,17,9,26,10,37,14,48,9,57,9,60,16,61,16,63,12,81,16,85,13,88,13,119,14,121,15,119,15,113,29,127",
  --inner curve right
  "61,25,61,22,58,19,54,19,54,14,60,15,66,18,68,21,68,25,66,28,59,34,58,32,61,25",
  --inner curve left
  "24,43,18,37,14,28,14,25,17,18,22,13,24,12,24,16,26,16,26,19,20,25,20,33,25,43,24,43",
  --lower right floating corner
  "48,122,64,106,64,93,63,92,61,94,61,106,53,113,48,117,48,122",
  --lower left floating corner
  "31,122,15,106,15,93,16,92,18,94,18,106,26,113,31,117,31,122"
 }
 for wall_group in all(wall_groups) do
  for wall_col in all(create_walls(wall_group)) do
   local wall = init_wall(wall_col)
   add(static_colliders,wall)
   add(static_over,wall)
  end
 end
end

function init_wall(
 _collider,
 _complete,
 _origin
)
 -- create a wall
_origin=_origin or vec(0.5,0.5)
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

function create_walls(str_input)
 local _pnts = gen_polygon(str_input)
 local _wall_list = {}
 for i=2,#_pnts do
  local _poly={_pnts[i-1],_pnts[i]}
  add(_wall_list,_poly)
 end
 return _wall_list
end

function draw_wall(wall)
 -- if draw_outlines then
 --  draw_collider(wall)
 -- end
end
