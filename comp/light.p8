function init_lights()
 -- initialise decorative lights
 refuel_lights={
  elements={
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
  },
  update=update_elem_group,
  all_lit_action=refuel_lights_all_lit,
  flash=0,
  not_reset=true
 }
 for _l in all(
  refuel_lights.elements
 ) do
  add(static_under,_l)
 end
 add(to_update,refuel_lights)
end

function create_light(
 _origin,
 _config,
 _off_col,
 _lit_col,
 _draw
)
 -- create light object
 -- args:
 -- _origin (vector): origin of
 --  light on the board.
 -- _config (any): Additional
 --  data to help draw the light
 -- _off_col (int): Colour of
 --  the light when off.
 -- _lit_col (int): Colour of
 --  light when on.
 -- returns:
 -- table: the light
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
 for _l in all(refuel_lights.elements) do
  if not _l.lit then
   _l.lit = true
   return
  end
 end
end

function refuel_lights_all_lit()
 -- action for when all the
 -- refuel lights are lit.
 -- lights the refuel capture.
 captures[3].bonus_timer=-1
end
