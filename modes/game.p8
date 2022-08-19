function init_game()
 debug_flippers=false
 draw_outlines=false

 init_flippers()

 msg=""

 pinballs={}
 static_colliders={}
 always_colliders={}
 static_over={}
 static_under={}
 to_update={}
 msgs={}
 ongoing_msgs={}
 launch_msg={
  "⬆️/⬇️:",
  " set power",
  "🅾️: launch"
 }

 action_queue={}

 init_walls()
 init_lights()
 init_round_bumpers()
 init_poly_bumpers()
 init_targets()
 init_spinners()
 init_rollovers()
 init_captures()
 init_launcher()
 init_launch_triggers()

 collision_regions=gen_collision_regions(
  static_colliders,0,0,79,127,16
 )

 score=init_long(3)

 tracker_cols={5,13}
 hits=0

 multiplier=1
 
 impact_pnt=nil
 dir_pnt=nil
end

function update_game()
 if pc_option==1 then
  if btnp(❎) then
   draw_outlines=not draw_outlines
  end
 end

 for _s in all(static_colliders) do
  _s.c=6
 end

 dt=1
 for _f in all(flippers) do
  dt=max(dt,update_flipper(_f))
 end
 for pinball in all(pinballs) do
  dt=max(dt,update_pinball_spd_acc(pinball))
 end

 for pinball in all(pinballs) do
  for _t in all(pinball.trackers) do
   _t.l-=0.5
   if _t.l < 0 then
    del(pinball.trackers,_t)
   end
  end
 end

 for i=1,dt do
  
  for _f in all(flippers) do
   update_flipper_pos(_f,dt)
  end
  for pinball in all(pinballs) do
   if not pinball.captured then
    for _f in all(flippers) do
     check_collision(pinball,_f)
    end
    update_pinball_pos(pinball,dt)
   end
  end
 end

 for _obj in all(to_update) do
  _obj:update()
 end

 for _action in all(action_queue) do
  _action.delay -= 1
  if _action.delay <= 0 then
   del(action_queue,_action)
   _action.func(unpack(_action.args))
  end
 end
 
 if #pinballs==0 then
  mode=modes.launch
  mode.init()
 end

 if #msgs > 0 then
  msgs[1].t-=1
  if msgs[1].t <= 0 then
   del(msgs,msgs[1])
  end
 end
end

function add_tracker(pinball)
 add(pinball.trackers,{
   x=pinball.origin.x,y=pinball.origin.y,l=7
  })
end

function draw_game()
 cls(0)

 rectfill(81,0,127,127,1)
 
 rect(81,0,127,127,5)
 rectfill(82,4,126,10,0)
 rectfill(82,18,126,42,0)
 print_long(score,84,5,5,10)
 print(msg,84,60,12)

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

 if #msgs > 0 then
  local _m=msgs[1]
  for i=1,#_m do
   print(_m[i],83,12+i*8,get_frame({10,7,12,7},_m.t,15))
  end
 elseif #ongoing_msgs > 0 then
  local _m=ongoing_msgs[#ongoing_msgs]
  for i=1,#_m do
   print(_m[i],83,12+i*8,10)
  end
 end

 circ(124,124,2,10)
 pset(124.5+sin(f/(16*60))*2.5,124.5+cos(f/(16*60))*2.5,8)


 if impact_pnt and debug_flippers then
  circ(impact_pnt.x,impact_pnt.y,2,8)
  line(impact_pnt.x,impact_pnt.y,dir_pnt.x,dir_pnt.y,10)
 end
end

function pass()
end
