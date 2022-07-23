function init_rollovers()
 -- initialize rollovers
 top_rollovers={
  elements={
   create_rollover(28,19),
   create_rollover(34,17),
   create_rollover(40,16),
   create_rollover(46,17),
   create_rollover(52,19)
  },
  update=update_elem_group,
  all_lit_action=increase_multi,
  rotatable=true,
  flash=0
 }
 bottom_rollovers={
  elements={
   create_rollover(14,95,light_refuel_lights),
   create_rollover(20,97,light_refuel_lights),
   create_rollover(65,95,light_refuel_lights),
   create_rollover(59,97,light_refuel_lights)
  },
  update=update_elem_group,
  all_lit_action=rollovers_all_lit,
  flash=0
 }
 for _r in all(bottom_rollovers.elements) do
  add(static_under,_r)
  add(static_colliders,_r)
  add(to_update,_r)
 end
 for _r in all(top_rollovers.elements) do
  add(static_under,_r)
  add(static_colliders,_r)
  add(to_update,_r)
 end
 add(to_update,top_rollovers)
 add(to_update,bottom_rollovers)
end

function create_rollover(_x,_y,_action)
 -- create a rollover
 return {
  origin=vec(_x,_y),
  simple_collider={x1=-2,y1=0,x2=2,y2=3},
  draw=draw_spr,
  check_collision=check_collision_with_rollover,
  lit_spr=53,
  unlit_spr=37,
  spr_i=37,
  spr_off=vec(-1,0),
  lit=false,
  reset_timer=0,
  update=update_rollover,
  c=7,
  action=_action
 }
end

function set_light(_r,_lit)
 -- set light status for a
 -- rollover
 -- args:
 -- _r (table): the rollover
 -- _lit (bool): status to set
 _r.lit=_lit
 if _lit then
  _r.spr_i=_r.lit_spr
 else
  _r.spr_i=_r.unlit_spr
 end
end

function check_collision_with_rollover(_r)
 -- action to trigger when box
 -- collider is triggered
 -- args:
 -- the rollover
 if _r.reset_timer > 0 then
  return
 end
 set_light(_r,true)
 _r.reset_timer=20
 increase_score(12500)
 if _r.action != nil then
   _r.action()
 end
end

function update_rollover(_r)
 -- reduce timer each frame
 _r.reset_timer=max(0,_r.reset_timer-1)
end

function rollovers_all_lit(_rg)
 -- action for when rollover
 -- group's lights all lit.
 increase_score(150,1)
 for _r in all(_rg.elements) do
  set_light(_r,false)
 end
end

function increase_multi(_rg)
 if multiplier<4 then
  add(msgs,{"multiplier","increased!",t=120})
 end
 multiplier=min(4,multiplier+1)
 rollovers_all_lit(_rg)
end
