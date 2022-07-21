function init_launcher()
 local _col=gen_polygon("-1,-0.5,3,-0.5")
 launcher={
  origin=vec(73,78),
  collider=_col,
  simple_collider=gen_simple_collider(_col),
  complete=false,
  check_collision=check_collision_with_collider,
  draw=draw_launcher,
  c=7
 }
 add(static_under,launcher)
 add(always_colliders,launcher)
end

function draw_launcher(_l)
 line(73,_l.origin.y+1,75,_l.origin.y+1,4)
 fillp(0b1111000011110000)
 rectfill(73,_l.origin.y+2,75,111,214)
 fillp()
end
