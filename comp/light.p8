function init_lights()
 -- initialise decorative lights
 refuel_lights={
  create_light(
   vec(39,84),
   vec(41,84),
   4,10,
   draw_line_light
  ),
  create_light(
   vec(39,82),
   vec(41,82),
   4,10,
   draw_line_light
  ),
  create_light(
   vec(39,80),
   vec(41,80),
   4,10,
   draw_line_light
  ),
  create_light(
   vec(39,78),
   vec(41,78),
   4,10,
   draw_line_light
  ),
  create_light(
   vec(39,76),
   vec(41,76),
   4,10,
   pass
  ),
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
 _off_col,
 _lit_col,
 _draw
)
 -- create light object
 return {
  origin=_origin,
  config=_config,
  off_col=_off_col,
  lit_col=_lit_col,
  draw=_draw,
  lit=false
 }
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
 for i = 1,#refuel_lights do
  local _l=refuel_lights[i]
  if not _l.lit then
   _l.lit = true
   if i == 5 then
    captures[3].bonus_timer=-1
    add(ongoing_msgs,refuel_msg)
   end
   return
  end
 end
end
