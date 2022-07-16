function init_lights()
 refuel_lights={
  elements={
  create_light(
   {x=39,y=84},
   {x=41,y=84},
   4,10,
   draw_line_light
  ),
  create_light(
   {x=39,y=82},
   {x=41,y=82},
   4,10,
   draw_line_light
  ),
  create_light(
   {x=39,y=80},
   {x=41,y=80},
   4,10,
   draw_line_light
  ),
  create_light(
   {x=39,y=78},
   {x=41,y=78},
   4,10,
   draw_line_light
  ),
  create_light(
   {x=39,y=76},
   {x=41,y=76},
   4,10,
   pass
  ),
  },
  update=update_elem_group,
  all_lit_action=refuel_lights_all_lit,
  flash=0,
  not_reset=true
 }
 for _l in all(refuel_lights.elements) do
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
 local _c = _l.off_col
 if _l.lit then
  _c=_l.lit_col
 end
 line(_l.origin.x, _l.origin.y, _l.config.x, _l.config.y, _c)
end

function light_refuel_lights()
 for _l in all(refuel_lights.elements) do
  if not _l.lit then
   _l.lit = true
   return
  end
 end
end

function refuel_lights_all_lit()
 captures[3].bonus_timer=-1
end
