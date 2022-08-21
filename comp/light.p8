function init_lights()
 -- initialise decorative lights
 chevron_light_cofig = {
   spr_coords=vec(32,9),
   unlit_col=4,
   spr_w=3,
   spr_h=3,
   hit=0
  }
 left_drain_light = create_light(
  vec(13,108),
  chevron_light_cofig,
  draw_spr
 )
 left_drain_light.lit=true
 add(static_under,left_drain_light)
 right_drain_light = create_light(
  vec(64,108),
  chevron_light_cofig,
  draw_spr
 )
 right_drain_light.lit=true
 add(static_under,right_drain_light)

 refuel_lights={
  create_light(
   vec(39,76),
   chevron_light_cofig,
   draw_spr
  ),
  create_light(
   vec(39,79),
   chevron_light_cofig,
   draw_spr
  ),
  create_light(
   vec(39,82),
   chevron_light_cofig,
   draw_spr
  ),
  create_light(
   vec(39,85),
   chevron_light_cofig,
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
  off_col=_off_col,
  lit_col=_lit_col,
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
