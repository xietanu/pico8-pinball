function init_game()
 show_stars = false
 got_highscore = 0
 balls=3

 msg=""

 msgs={}
 ongoing_msgs={}
 launch_msg={
  "⬆️/⬇️:",
  " set power",
  "🅾️: launch"
 }

 init_table()

 action_queue={}

 score=init_long(3)

 --TODO: Delete these debug variables
 -- draw_outlines=false
end

function update_game()
 -- if pc_option==1 then
 --  if btnp(❎) then
 --   draw_outlines=not draw_outlines
 --  end
 -- end

 for _s in all(static_colliders) do
  _s.c=6
 end

 dt=1
 for _f in all(flippers) do
  dt=max(dt,update_flipper(_f))
 end

 for pinball in all(pinballs) do
  dt=max(dt,update_pinball_spd_acc(pinball))
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
  if balls == 0 then
   mode = modes.game_over
   mode.init()
   return
  end
  mode=modes.launch
  mode.init()
 end

 if #msgs > 0 then
  msgs[1].t-=1
  if msgs[1].t <= 0 then
   del(msgs,msgs[1])
  end
 end

 planet_lights_lit=max(planet_lights_lit-0.005,0)
 set_planet_lights()
end

function draw_game()
 draw_headboard()

 draw_table()

 if #msgs > 0 then
  local _m=msgs[1]
  for i=1,#_m do
   print(_m[i],83,34+i*8,get_frame({10,7,12,7},_m.t,15))
  end
 elseif #ongoing_msgs > 0 then
  local _m=ongoing_msgs[#ongoing_msgs]
  for i=1,#_m do
   print(_m[i],83,34+i*8,10)
  end
 end

 circ(124,124,2,10)
 pset(124.5+sin(f/(16*60))*2.5,124.5+cos(f/(16*60))*2.5,8)
end

function pass()
end

function draw_headboard(_score_col)
 _score_col = _score_col or 10
 rectfill(81,0,127,127,1)

 print_shadow("terra nova",85,5,7,8)
 print_shadow("pinball",89,11,7,8)
 
 rect(81,0,127,127,5)
 rectfill(82,20,126,33,0)
 rectfill(82,40,126,64,0)

 print_long(score,84,21,5,_score_col)
 print("balls:",84,28,10)
 print(balls,122,28,10)
end
