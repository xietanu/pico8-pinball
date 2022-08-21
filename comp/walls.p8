function init_walls()
 -- initialize outer walls

 wall_groups = {
  "50,127,64,113,64,119,65,122,66,119,66,88,63,85,67,81,63,70,69,60,69,57,67,57,62,61,50,49,50,46,52,45,62,41,69,37,72,34",
  "75,27,75,21,71,14,64,7,54,2,48,1,34,1,26,3,18,7,13,12,10,17,9,26,10,37,14,48,7,52,7,55,17,56,12,81,16,85,13,88,13,121,15,121,15,113,29,127"
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
 if draw_outlines then
  draw_collider(wall)
 end
end
