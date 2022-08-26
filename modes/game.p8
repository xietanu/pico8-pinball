function init_game()
 show_stars = false
 got_highscore = 0
 balls=3
 planet_lights_lit=0.75

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

 update_spinner()

 for _action in all(action_queue) do
  _action.delay -= 1
  if _action.delay <= 0 then
   del(action_queue,_action)
   _action.func(unpack(_action.args))
  end
 end
 
 if #pinballs==0 then
  if balls == 0 and not reset_light.lit then
   end_target_hunt()
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

 planet_lights_lit=max(planet_lights_lit-0.0025,0.75)
 set_planet_lights()
end

function draw_game()
 draw_backboard()

 draw_table()

 if #msgs > 0 then
  local _m=msgs[1]
  for i=1,#_m do
   print(_m[i],83,31+i*8,get_frame({10,7,12,7},_m.t,15))
  end
 elseif #ongoing_msgs > 0 then
  local _m=ongoing_msgs[#ongoing_msgs]
  for i=1,#_m do
   print(_m[i],83,31+i*8,10)
  end
 end

end

function pass()
end

function draw_backboard(_score_col)
 _score_col = _score_col or 10
 fillp(0b1101000010110000.1)
 rectfill(81,0,127,127,5)
 fillp()

 rectfill(81,16,127,47,1)
 spr(112,80,18,6,2)
 
 rect(81,0,127,127,5)
 rect(81,0,127,15,5)
 rect(81,36,127,63,5)
 rectfill(82,1,126,14,0)
 rectfill(82,37,126,62,0)

 sspr(1,80,47,48,82,72)
 sspr(1,80,47,48,81,72)

 print_long(score,84,2,5,_score_col)
 print("balls:",84,9,10)
 print(balls,122,9,10)
end
