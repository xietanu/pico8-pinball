function init_rollovers()
 -- initialize rollovers
 top_rollovers={
  elements={},
  all_lit_action=increase_multi,
  sfx=25
 }
 for i=0,4 do
  add(top_rollovers.elements,create_rollover(28.5+6*i,15.5))
 end
 bottom_rollovers={
  elements={
   create_rollover(14.5,95.5,hit_refuel_rollover),
   create_rollover(20.5,97.5,hit_refuel_rollover),
   create_rollover(65.5,95.5,hit_refuel_rollover),
   create_rollover(59.5,97.5,hit_refuel_rollover)
  },
  all_lit_action=rollovers_all_lit,
  sfx=27
 }
 add_target_group_to_board(top_rollovers,static_under)
 add_target_group_to_board(bottom_rollovers,static_under)
end

function create_rollover(_x,_y,_action)
 -- create a rollover
 return {
  origin=vec(_x,_y),
  simple_collider={x1=-2,y1=0,x2=2,y2=3},
  draw=draw_spr,
  check_collision=check_collision_with_rollover,
  spr_coords=vec(37,0),
  spr_w=3,
  spr_h=8,
  spr_off=vec(-1,0),
  unlit_col=4,
  hit=0,
  action=_action
 }
end

function set_light(_r,_lit)
 -- set light status for an element
 _r.lit=_lit
end

function check_collision_with_rollover(_r,_pin)
 -- action to trigger when box
 -- collider is triggered
 if _r.deactivated then
  return
 end
 if not _r.lit then
  sfx(26)
 end
 set_light(_r,true)
 if _r.group then
  group_elem_lit(_r.group)
 end

 _r.deactivated=true
 add_to_queue(reactivate,20,{_r})
 increase_score(1234)
 if _r.action != nil then
   _r.action(_r,_pin)
 end
end

function rollovers_all_lit(_rg)
 -- action for when rollover
 -- group's lights all lit.
 increase_score(50,1)
 for _r in all(_rg.elements) do
  set_light(_r,false)
 end
end

function hit_refuel_rollover(_r,_pin)
 if _pin.spd.y > 0 then
  light_refuel_lights()
 end
end

function increase_multi(_rg)
 light_orbit(3)
 if multiplier<4 then
  add(msgs,{"multiplier","increased!",t=120})
 end
 multiplier=min(4,multiplier+1)
 rollovers_all_lit(_rg)
end
