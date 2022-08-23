function init_lights()
 -- initialise decorative lights
 chevron_light_spr = create_light_spr(
  vec(32,9),3,3
 )
 up_chevron_light_spr = create_light_spr(
  vec(32,9),3,3,false,true
 )
 h_chevron_light_spr = create_light_spr(
  vec(35,9),3,3
 )
 small_up_right_chevron_spr = create_light_spr(
  vec(33,12),2,2
 )
 big_up_right_chevron_spr = create_light_spr(
  vec(32,12),3,3
 )

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
   vec(20,36),
   vec(20,37),
   draw_line_light
  ),
  create_light(
   vec(19,34),
   vec(19,35),
   draw_line_light
  ),
  create_light(
   vec(18,32),
   vec(18,33),
   draw_line_light
  ),
  create_light(
   vec(17,30),
   vec(17,31),
   draw_line_light
  ),
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

 for _l in all(
  spinner_lights
 ) do
  add(static_under,_l)
 end

 refuel_lights={
  create_light(
   vec(47,57),
   h_chevron_light_spr,
   draw_spr
  ),
  create_light(
   vec(50,57),
   h_chevron_light_spr,
   draw_spr
  ),
  create_light(
   vec(53,57),
   h_chevron_light_spr,
   draw_spr
  ),
  create_light(
   vec(56,57),
   h_chevron_light_spr,
   draw_spr
  )
 }
 for _l in all(
  refuel_lights
 ) do
  add(static_under,_l)
 end
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
 -- args:
 -- _l (table): the light
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

function create_light_spr(
 _spr_coord,
 _w,_h,
 _flip_x,
 _flip_y
)
 return {
  spr_coords=_spr_coord,
  unlit_col=4,
  spr_w=_w,
  spr_h=_h,
  hit=0,
  flip_x=_flip_x,
  flip_y=_flip_y
 }
end

function light_refuel_lights()
 -- action for progressive
 -- lighting of refuel lights.
 -- lights a light each time
 -- it's triggered.
 if blastoff_mode then
  return
 end
 for i = 1,#refuel_lights do
  local _l=refuel_lights[i]
  if not _l.lit then
   _l.lit = true
   if i == 4 then
    flash(captures[3],-99,true)
    add(ongoing_msgs,refuel_msg)
   end
   return
  end
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
