function init_table()
 multiplier=1

 pinballs={}
 static_colliders={}
 always_colliders={}
 static_over={}
 static_under={}

 init_walls()
 init_lights()
 init_round_bumpers()
 init_poly_bumpers()
 init_targets()
 init_spinners()
 init_rollovers()
 init_kickouts()
 init_launcher()
 init_launch_triggers()
 init_flippers()

 collision_regions=gen_collision_regions(
  0,0,79,127,16
 )
end

function draw_table()
 map()

 for _sc in all(static_under) do
  _sc:draw()
 end

 for pinball in all(pinballs) do
  for _t in all(pinball.trackers) do
   circfill(_t.x,_t.y,flr(_t.l/6),tracker_cols[1+flr(_t.l/4)])
  end
  draw_pinball(pinball)
 end
 
 for _sc in all(static_over) do
  _sc:draw()
 end
 foreach(flippers,draw_flipper)
 
 local _multi_y=115-multiplier*6
 rectfill(9,_multi_y-1,10,_multi_y,10)
end