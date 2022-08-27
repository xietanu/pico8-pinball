function init_walls()
 -- initialize outer walls

 wall_groups = {
  --right side
  "50,127,64,113,64,119,65,122,66,119,66,88,63,85,67,81,63,70,69,60,69,57,67,57,62,61,53,47,53,46,56,43,62,41,68,38,72,34",
  --left/top side
  "75,27,75,21,71,14,64,7,54,2,48,1,34,1,26,3,18,7,13,12,10,17,9,26,10,37,14,47,9,55,9,58,16,62,16,63,12,81,16,85,13,88,13,119,14,121,15,119,15,113,29,127",
  --inner curve right
  "61,25,61,22,58,19,54,19,54,14,60,15,66,18,68,21,68,25,66,28,59,34,58,32,61,25",
  --inner curve left
  "24,43,18,37,14,28,14,25,17,18,22,13,24,12,24,16,26,16,26,19,20,25,20,33,25,43,24,43",
  --lower right floating corner
  "48,122,64,106,64,93,63,92,61,94,61,105,53,112,48,117.5,48,122",
  --lower left floating corner
  "31,122,15,106,15,93,16,92,18,94,18,105,26,112,31,117.5,31,122",
  --narrow walls
  "30,15,31,14,32,15,32,18,31,19,30,18,30,15",
  "36,15,37,14,38,15,38,18,37,19,36,18,36,15",
  "42,15,43,14,44,15,44,18,43,19,42,18,42,15",
  "48,15,49,14,50,15,50,18,49,19,48,18,48,15"
 }
 for wall_group in all(wall_groups) do
  local _pnts = gen_polygon(wall_group)
  local _wall_list = {}
  for i=2,#_pnts do
   local _poly={_pnts[i-1],_pnts[i]}
   add(_wall_list,_poly)
  end
  for wall_col in all(_wall_list) do
   add(
    static_colliders,
    {
     origin=vec(0.5,0.5),
     collider=wall_col,
     simple_collider=gen_simple_collider(wall_col),
     check_collision=check_collision_with_collider
    }
   )
  end
 end
end
