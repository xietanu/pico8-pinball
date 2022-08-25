function init_lights()
 -- initialise decorative lights
 chevron_light_spr = create_light_spr(
  vec(32,9)
 )
 up_chevron_light_spr = create_light_spr(
  vec(35,12)
 )
 h_chevron_light_spr = create_light_spr(
  vec(35,9)
 )
 small_up_right_chevron_spr = create_light_spr(
  vec(33,12),2,2
 )
 big_up_right_chevron_spr = create_light_spr(
  vec(32,12)
 )
 orbit_lights = {}
 for i=1,5 do
  add(
   orbit_lights,
   create_light(
    vec(27+i*4,93),
    sub("orbit",i,i),
    draw_letter_light
   )
  )
 end

 add_group_to_board(orbit_lights,{static_under})

 pent_lights={}
 for i=0,0.8,0.2 do
  add(
   pent_lights,
   create_light(
    vec(64.5-sin(i)*4,49.5-cos(i)*4),
    nil,
    draw_dot_light
   )
  )
 end
 add_group_to_board(pent_lights,{static_under})

 left_drain_light = create_light(
  vec(13,108),
  chevron_light_spr,
  draw_spr
 )
 left_drain_light.lit=true
 add(static_under,left_drain_light)
 right_drain_light = create_light(
  vec(64,108),
  chevron_light_spr,
  draw_spr
 )
 right_drain_light.lit=true
 add(static_under,right_drain_light)

 spinner_lights={
  create_light(
   vec(16,27),
   up_chevron_light_spr,
   draw_spr
  ),
  create_light(
   vec(16,24),
   up_chevron_light_spr,
   draw_spr
  ),
  create_light(
   vec(17,22),
   small_up_right_chevron_spr,
   draw_spr
  ),
  create_light(
   vec(18,20),
   big_up_right_chevron_spr,
   draw_spr
  ),
  create_light(
   vec(20,18),
   big_up_right_chevron_spr,
   draw_spr
  )
 }
 for i=0,3 do
  add(
   spinner_lights,
    create_light(
    vec(20-i,36-i*2),
    vec(20-i,37-i*2),
    draw_line_light
   ),
   i+1
  )
 end

 add_group_to_board(spinner_lights,{static_under})

 refuel_lights={}
 for i=0,3 do
  add(
   refuel_lights,
   create_light(
    vec(47+i*3,57),
    h_chevron_light_spr,
    draw_spr
   )
  )
 end
 add_group_to_board(refuel_lights,{static_under})

 reset_light = create_light(
  vec(39,125),nil,draw_dot_light
 )
 add(static_under,reset_light)

 planet_lights={}
 for i=1,10 do
  local _x = 65-abs(5.5-i)/2
  add(
   planet_lights,
   create_light(
    vec(_x,29-i),
    vec(_x+1,29-i),
    draw_line_light
   )
  )
 end
 add_group_to_board(planet_lights,{static_under})
end

function create_light(
 _origin,
 _config,
 _draw,
 _off_col,
 _lit_col
)
 -- create light object
 local _l = {
  origin=_origin,
  config=_config,
  off_col=_off_col or 4,
  lit_col=_lit_col or 10,
  draw=_draw,
  lit=false,
  spr_off=vec(0,0)
 }
 if _draw == draw_spr then
  for k,v in pairs(_config) do
   _l[k]=v
  end
 end
 return _l 
end

function draw_line_light(_l)
 -- draw a line-like light
 local _c = _l.off_col
 if _l.lit then
  _c=_l.lit_col
 end
 line(
  _l.origin.x,
  _l.origin.y,
  _l.config.x,
  _l.config.y,
  _c
 )
end

function draw_letter_light(_l)
 local _c = _l.off_col
 if _l.lit then
  _c=_l.lit_col
 end
 print(
  _l.config,
  _l.origin.x,
  _l.origin.y,
  _c
 )
end

function draw_dot_light(_l)
 local _c = _l.off_col
 if _l.lit then
  _c=_l.lit_col
 end
 rect(
  _l.origin.x,
  _l.origin.y,
  _l.origin.x+1,
  _l.origin.y+1,
  _c
 )
end

function create_light_spr(
 _spr_coord,
 _w,_h
)
 return {
  spr_coords=_spr_coord,
  unlit_col=4,
  spr_w=_w or 3,
  spr_h=_h or 3,
  hit=0
 }
end

function light_refuel_lights()
 -- action for progressive
 -- lighting of refuel lights.
 -- lights a light each time
 -- it's triggered.
 if blastoff_mode or #pinballs > 1 then
  return
 end
 for i = 1,#refuel_lights do
  local _l=refuel_lights[i]
  if not _l.lit then
   _l.lit = true
   if i == 4 then
    flash(captures[3],-99,true)
   end
   return
  end
 end
end

function update_target_hunt_lights()
 for i = 1,5 do
  pent_lights[i].lit=target_hunt_cnt>=i
 end
end

function cycle_lights(_group,_next_index,_times,_delay)
 _group[mod(_next_index-1,#_group)].lit = false

 if _next_index > #_group*_times then
  return
 end

 _group[mod(_next_index,#_group)].lit = true
 add_to_queue(cycle_lights,_delay,{_group,_next_index+1,_times,_delay})
end

function light_orbit(i)
 orbit_lights[i].lit=true
 local _cnt = 0
 for _l in all(orbit_lights) do
  _cnt+=tonum(_l.lit)
 end
 if _cnt==5 then
  add(msgs,{"explorer","bonus!","extra ball!"})
  increase_score(1,2)
  balls+=1
  flash_table(orbit_lights,3,false)
 else
  flash(orbit_lights[i],3,true)
 end
end
